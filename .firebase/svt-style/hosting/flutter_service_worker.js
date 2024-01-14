'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "397dd6781add8ad711b563ea9642bcff",
"favicon.ico": "9ec0abd4682eae1e0a22968df07bd322",
"apple-touch-icon-120x120.png": "2145f5126e419e2a490d709a5ee5b342",
"index.html": "e8c8564a42cb163a577dcffc4ff4598f",
"/": "e8c8564a42cb163a577dcffc4ff4598f",
"apple-touch-icon.png": "519459c6729750230bee68838fdd40df",
"main.dart.js": "61334ad1a032499b649920f9135cbca6",
"apple-touch-icon-152x152.png": "0c6ac03a38fac8277f8ef9e78cb86836",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"apple-touch-icon-180x180.png": "4bc62656efb73582bca67907f5772c25",
"apple-touch-icon-114x114.png": "0bfba534faf850d50b6869cab2302093",
"apple-touch-icon-76x76.png": "1fa22330fe1b65fb37102ccb7bf956d0",
"app-icon.png": "bd433723f2becec11210cd2e39f09588",
"apple-touch-icon-57x57.png": "519459c6729750230bee68838fdd40df",
"icons/Icon-192.png": "e5865595fb901c1eb0399e99d8e75b12",
"icons/Icon-maskable-192.png": "514414ad3604eab45e56457be9706919",
"icons/Icon-maskable-512.png": "0f24908ffef4289376bb9306256607bb",
"icons/Icon-512.png": "f61bd0f02028852fb911e836de00021f",
"manifest.json": "9be11f4c6f3ebc3c52da2b2778f629fc",
"apple-touch-icon-72x72.png": "f5399655c9c3fea44d2ef25dbcb42ac6",
"assets/AssetManifest.json": "e191bf7c0f5f3c4aab50b32e958fc09b",
"assets/NOTICES": "f89a561934efae4fac429153958a8bdd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "6221f32a6e0e116b30f46824383f38ce",
"assets/fonts/MaterialIcons-Regular.otf": "a744ee05cfd286c91b2285f122d42b71",
"assets/assets/images/wonwoo.jpg": "7e35044386ae02b37328c4b80ec5671d",
"assets/assets/images/the8.jpg": "67d757b1cd180bff5362037f2b56c767",
"assets/assets/images/woozi.jpg": "8437f38b78652c68f2f7028051b527c5",
"assets/assets/images/vernon.jpg": "761cecb095c3919e1cc0821a89085ebe",
"assets/assets/images/scoups.jpg": "bb51dce096e1bf3e7156d37b7d2b4c60",
"assets/assets/images/joshua.jpg": "359586c11a307809a4a4257287845099",
"assets/assets/images/dino.jpg": "15aa8f66042cd7a1813ec523a0a2c316",
"assets/assets/images/hoshi.jpg": "3746493bba37af0f7553d8455432531f",
"assets/assets/images/jeonghan.jpg": "13b006c43a52c4a0824633f120fd70d2",
"assets/assets/images/app-icon.png": "bd433723f2becec11210cd2e39f09588",
"assets/assets/images/dokyeom.jpg": "d30bb737d2f93ff1f86d6aabb1e103e3",
"assets/assets/images/jun.jpg": "1999907bbdbb213e690c159cfb7fbac3",
"assets/assets/images/seungkwan.jpg": "c77e3ee2c0fa2e09f3b762a3e532de90",
"assets/assets/images/mingyu.jpg": "986728f76ad57bd3ef65f557173d4b0c",
"apple-touch-icon-144x144.png": "5161d2b39a7af1b54856ec5ad1918aad",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
