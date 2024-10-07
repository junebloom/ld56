
var Module;

if (typeof Module === 'undefined') Module = eval('(function() { try { return Module || {} } catch(e) { return {} } })()');

if (!Module.expectedDataFileDownloads) {
  Module.expectedDataFileDownloads = 0;
  Module.finishedDataFileDownloads = 0;
}
Module.expectedDataFileDownloads++;
(function() {
 var loadPackage = function(metadata) {

  var PACKAGE_PATH;
  if (typeof window === 'object') {
    PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
  } else if (typeof location !== 'undefined') {
      // worker
      PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
    } else {
      throw 'using preloaded data can only be done on a web page or in a web worker';
    }
    var PACKAGE_NAME = 'game.data';
    var REMOTE_PACKAGE_BASE = 'game.data';
    if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
      Module['locateFile'] = Module['locateFilePackage'];
      Module.printErr('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
    }
    var REMOTE_PACKAGE_NAME = typeof Module['locateFile'] === 'function' ?
    Module['locateFile'](REMOTE_PACKAGE_BASE) :
    ((Module['filePackagePrefixURL'] || '') + REMOTE_PACKAGE_BASE);

    var REMOTE_PACKAGE_SIZE = metadata.remote_package_size;
    var PACKAGE_UUID = metadata.package_uuid;

    function fetchRemotePackage(packageName, packageSize, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        var size = packageSize;
        if (event.total) size = event.total;
        if (event.loaded) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: size
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
            var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onerror = function(event) {
        throw new Error("NetworkError for: " + packageName);
      }
      xhr.onload = function(event) {
        if (xhr.status == 200 || xhr.status == 304 || xhr.status == 206 || (xhr.status == 0 && xhr.response)) { // file URLs can return 0
          var packageData = xhr.response;
          callback(packageData);
        } else {
          throw new Error(xhr.statusText + " : " + xhr.responseURL);
        }
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };

    function runWithFS() {

      function assert(check, msg) {
        if (!check) throw msg + new Error().stack;
      }
      Module['FS_createPath']('/', 'assets', true, true);
      Module['FS_createPath']('/', 'entities', true, true);
      Module['FS_createPath']('/', 'systems', true, true);
      Module['FS_createPath']('/', 'utilities', true, true);

      function DataRequest(start, end, crunched, audio) {
        this.start = start;
        this.end = end;
        this.crunched = crunched;
        this.audio = audio;
      }
      DataRequest.prototype = {
        requests: {},
        open: function(mode, name) {
          this.name = name;
          this.requests[name] = this;
          Module['addRunDependency']('fp ' + this.name);
        },
        send: function() {},
        onload: function() {
          var byteArray = this.byteArray.subarray(this.start, this.end);

          this.finish(byteArray);

        },
        finish: function(byteArray) {
          var that = this;

        Module['FS_createDataFile'](this.name, null, byteArray, true, true, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
        Module['removeRunDependency']('fp ' + that.name);

        this.requests[this.name] = null;
      }
    };

    var files = metadata.files;
    for (i = 0; i < files.length; ++i) {
      new DataRequest(files[i].start, files[i].end, files[i].crunched, files[i].audio).open('GET', files[i].filename);
    }


    var indexedDB = window.indexedDB || window.mozIndexedDB || window.webkitIndexedDB || window.msIndexedDB;
    var IDB_RO = "readonly";
    var IDB_RW = "readwrite";
    var DB_NAME = "EM_PRELOAD_CACHE";
    var DB_VERSION = 1;
    var METADATA_STORE_NAME = 'METADATA';
    var PACKAGE_STORE_NAME = 'PACKAGES';
    function openDatabase(callback, errback) {
      try {
        var openRequest = indexedDB.open(DB_NAME, DB_VERSION);
      } catch (e) {
        return errback(e);
      }
      openRequest.onupgradeneeded = function(event) {
        var db = event.target.result;

        if(db.objectStoreNames.contains(PACKAGE_STORE_NAME)) {
          db.deleteObjectStore(PACKAGE_STORE_NAME);
        }
        var packages = db.createObjectStore(PACKAGE_STORE_NAME);

        if(db.objectStoreNames.contains(METADATA_STORE_NAME)) {
          db.deleteObjectStore(METADATA_STORE_NAME);
        }
        var metadata = db.createObjectStore(METADATA_STORE_NAME);
      };
      openRequest.onsuccess = function(event) {
        var db = event.target.result;
        callback(db);
      };
      openRequest.onerror = function(error) {
        errback(error);
      };
    };

    /* Check if there's a cached package, and if so whether it's the latest available */
    function checkCachedPackage(db, packageName, callback, errback) {
      var transaction = db.transaction([METADATA_STORE_NAME], IDB_RO);
      var metadata = transaction.objectStore(METADATA_STORE_NAME);

      var getRequest = metadata.get("metadata/" + packageName);
      getRequest.onsuccess = function(event) {
        var result = event.target.result;
        if (!result) {
          return callback(false);
        } else {
          return callback(PACKAGE_UUID === result.uuid);
        }
      };
      getRequest.onerror = function(error) {
        errback(error);
      };
    };

    function fetchCachedPackage(db, packageName, callback, errback) {
      var transaction = db.transaction([PACKAGE_STORE_NAME], IDB_RO);
      var packages = transaction.objectStore(PACKAGE_STORE_NAME);

      var getRequest = packages.get("package/" + packageName);
      getRequest.onsuccess = function(event) {
        var result = event.target.result;
        callback(result);
      };
      getRequest.onerror = function(error) {
        errback(error);
      };
    };

    function cacheRemotePackage(db, packageName, packageData, packageMeta, callback, errback) {
      var transaction_packages = db.transaction([PACKAGE_STORE_NAME], IDB_RW);
      var packages = transaction_packages.objectStore(PACKAGE_STORE_NAME);

      var putPackageRequest = packages.put(packageData, "package/" + packageName);
      putPackageRequest.onsuccess = function(event) {
        var transaction_metadata = db.transaction([METADATA_STORE_NAME], IDB_RW);
        var metadata = transaction_metadata.objectStore(METADATA_STORE_NAME);
        var putMetadataRequest = metadata.put(packageMeta, "metadata/" + packageName);
        putMetadataRequest.onsuccess = function(event) {
          callback(packageData);
        };
        putMetadataRequest.onerror = function(error) {
          errback(error);
        };
      };
      putPackageRequest.onerror = function(error) {
        errback(error);
      };
    };

    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;

        // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though
        // (we may be allocating before malloc is ready, during startup).
        if (Module['SPLIT_MEMORY']) Module.printErr('warning: you should run the file packager with --no-heap-copy when SPLIT_MEMORY is used, otherwise copying into the heap may fail due to the splitting');
        var ptr = Module['getMemory'](byteArray.length);
        Module['HEAPU8'].set(byteArray, ptr);
        DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);

        var files = metadata.files;
        for (i = 0; i < files.length; ++i) {
          DataRequest.prototype.requests[files[i].filename].onload();
        }
        Module['removeRunDependency']('datafile_game.data');

      };
      Module['addRunDependency']('datafile_game.data');

      if (!Module.preloadResults) Module.preloadResults = {};

      function preloadFallback(error) {
        console.error(error);
        console.error('falling back to default preload behavior');
        fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, processPackageData, handleError);
      };

      openDatabase(
        function(db) {
          checkCachedPackage(db, PACKAGE_PATH + PACKAGE_NAME,
            function(useCached) {
              Module.preloadResults[PACKAGE_NAME] = {fromCache: useCached};
              if (useCached) {
                console.info('loading ' + PACKAGE_NAME + ' from cache');
                fetchCachedPackage(db, PACKAGE_PATH + PACKAGE_NAME, processPackageData, preloadFallback);
              } else {
                console.info('loading ' + PACKAGE_NAME + ' from remote');
                fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE,
                  function(packageData) {
                    cacheRemotePackage(db, PACKAGE_PATH + PACKAGE_NAME, packageData, {uuid:PACKAGE_UUID}, processPackageData,
                      function(error) {
                        console.error(error);
                        processPackageData(packageData);
                      });
                  }
                  , preloadFallback);
              }
            }
            , preloadFallback);
        }
        , preloadFallback);

      if (Module['setStatus']) Module['setStatus']('Downloading...');

    }
    if (Module['calledRun']) {
      runWithFS();
    } else {
      if (!Module['preRun']) Module['preRun'] = [];
      Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
    }

  }
  loadPackage({"package_uuid":"16c00323-eadd-48ca-93be-6378319e4526","remote_package_size":1225661,"files":[{"filename":"/assets/bg.kra","crunched":0,"start":0,"end":206951,"audio":false},{"filename":"/assets/bg.kra~","crunched":0,"start":206951,"end":409368,"audio":false},{"filename":"/assets/bg.png","crunched":0,"start":409368,"end":410306,"audio":false},{"filename":"/assets/bg.png~","crunched":0,"start":410306,"end":411247,"audio":false},{"filename":"/assets/dysnomia.kra","crunched":0,"start":411247,"end":471062,"audio":false},{"filename":"/assets/dysnomia.kra~","crunched":0,"start":471062,"end":531333,"audio":false},{"filename":"/assets/dysnomia.png","crunched":0,"start":531333,"end":533918,"audio":false},{"filename":"/assets/font.kra","crunched":0,"start":533918,"end":585806,"audio":false},{"filename":"/assets/font.kra~","crunched":0,"start":585806,"end":637705,"audio":false},{"filename":"/assets/font.png","crunched":0,"start":637705,"end":638520,"audio":false},{"filename":"/assets/font.png~","crunched":0,"start":638520,"end":639437,"audio":false},{"filename":"/assets/planet.png","crunched":0,"start":639437,"end":641693,"audio":false},{"filename":"/assets/planet.png~","crunched":0,"start":641693,"end":644391,"audio":false},{"filename":"/assets/screen.kra","crunched":0,"start":644391,"end":807597,"audio":false},{"filename":"/assets/screen.kra~","crunched":0,"start":807597,"end":955523,"audio":false},{"filename":"/assets/spritesheet.kra","crunched":0,"start":955523,"end":1038408,"audio":false},{"filename":"/assets/spritesheet.kra~","crunched":0,"start":1038408,"end":1121811,"audio":false},{"filename":"/assets/spritesheet.png","crunched":0,"start":1121811,"end":1124883,"audio":false},{"filename":"/assets/spritesheet.png~","crunched":0,"start":1124883,"end":1127953,"audio":false},{"filename":"/assets/stars.png","crunched":0,"start":1127953,"end":1128594,"audio":false},{"filename":"/conf.lua","crunched":0,"start":1128594,"end":1128666,"audio":false},{"filename":"/entities/Creature.lua","crunched":0,"start":1128666,"end":1140516,"audio":false},{"filename":"/entities/ResourceNode.lua","crunched":0,"start":1140516,"end":1143320,"audio":false},{"filename":"/entities/StatNode.lua","crunched":0,"start":1143320,"end":1148076,"audio":false},{"filename":"/entities/UIElement.lua","crunched":0,"start":1148076,"end":1148132,"audio":false},{"filename":"/main.lua","crunched":0,"start":1148132,"end":1160558,"audio":false},{"filename":"/systems/detectCollisions.lua","crunched":0,"start":1160558,"end":1160863,"audio":false},{"filename":"/systems/drawHitboxes.lua","crunched":0,"start":1160863,"end":1161294,"audio":false},{"filename":"/systems/drawSprites.lua","crunched":0,"start":1161294,"end":1161909,"audio":false},{"filename":"/systems/drawText.lua","crunched":0,"start":1161909,"end":1162315,"audio":false},{"filename":"/systems/moveEntities.lua","crunched":0,"start":1162315,"end":1162528,"audio":false},{"filename":"/systems/processAnimations.lua","crunched":0,"start":1162528,"end":1163021,"audio":false},{"filename":"/systems/processBehaviorStates.lua","crunched":0,"start":1163021,"end":1163424,"audio":false},{"filename":"/systems/processEntityUpdate.lua","crunched":0,"start":1163424,"end":1163582,"audio":false},{"filename":"/systems/processFacing.lua","crunched":0,"start":1163582,"end":1163849,"audio":false},{"filename":"/systems/processMouseHover.lua","crunched":0,"start":1163849,"end":1164437,"audio":false},{"filename":"/ui.lua","crunched":0,"start":1164437,"end":1173539,"audio":false},{"filename":"/upgrades.lua","crunched":0,"start":1173539,"end":1196650,"audio":false},{"filename":"/utilities/brinevector.lua","crunched":0,"start":1196650,"end":1204361,"audio":false},{"filename":"/utilities/collision.lua","crunched":0,"start":1204361,"end":1205080,"audio":false},{"filename":"/utilities/debugger.lua","crunched":0,"start":1205080,"end":1225555,"audio":false},{"filename":"/utilities/id.lua","crunched":0,"start":1225555,"end":1225661,"audio":false}]});

})();
