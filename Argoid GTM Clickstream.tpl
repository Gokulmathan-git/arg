___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Argoid GTM Clickstream",
  "brand": {
    "id": "brand_dummy",
    "displayName": "Argoid"
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "accountId",
    "displayName": "Account ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "userId",
    "displayName": "User Identifier",
    "simpleValueType": true,
    "defaultValue": "{{argoidUserId}}"
  },
  {
    "type": "TEXT",
    "name": "gaId",
    "displayName": "Google Analytics ID",
    "simpleValueType": true,
    "defaultValue": "{{argoidGaId}}"
  },
  {
    "type": "TEXT",
    "name": "sourcePageUrl",
    "displayName": "Page url where the user is coming from previously",
    "simpleValueType": true,
    "defaultValue": "{{argoidSourcePageUrl}}"
  },
  {
    "type": "TEXT",
    "name": "clickSection",
    "displayName": "Click Section",
    "simpleValueType": true,
    "defaultValue": "{{argoidClickSection}}"
  },
  {
    "type": "TEXT",
    "name": "currentUrl",
    "displayName": "Url of the current page",
    "simpleValueType": true,
    "defaultValue": "{{argoidCurrentUrl}}"
  },
  {
    "type": "TEXT",
    "name": "productId",
    "displayName": "Product ID of product present in the page",
    "simpleValueType": true,
    "defaultValue": "{{argoidProductId}}"
  },
  {
    "type": "TEXT",
    "name": "ipAddress",
    "displayName": "IP ADDRESS",
    "simpleValueType": true,
    "defaultValue": "{{argoidIpAddress}}"
  },
  {
    "type": "TEXT",
    "name": "userAgent",
    "displayName": "User Agent of the browser",
    "simpleValueType": true,
    "defaultValue": "{{argoidUserAgent}}"
  },
  {
    "type": "TEXT",
    "name": "language",
    "displayName": "Language",
    "simpleValueType": true,
    "defaultValue": "{{argoidLanguage}}"
  },
  {
    "type": "TEXT",
    "name": "latitude",
    "displayName": "Latitude",
    "simpleValueType": true,
    "defaultValue": "{{argoidLatitude}}"
  },
  {
    "type": "TEXT",
    "name": "longitude",
    "displayName": "Longitude",
    "simpleValueType": true,
    "defaultValue": "{{argoidLongitude}}"
  },
  {
    "type": "TEXT",
    "name": "connectionSpeed",
    "displayName": "Connection Speed",
    "simpleValueType": true,
    "defaultValue": "{{argoidConnectionSpeed}}"
  },
  {
    "type": "TEXT",
    "name": "networkType",
    "displayName": "Network Type",
    "simpleValueType": true,
    "defaultValue": "{{argoidNetworkType}}"
  },
  {
    "type": "TEXT",
    "name": "deviceTimeZone",
    "displayName": "Device TimeZone",
    "simpleValueType": true,
    "defaultValue": "{{argoidDeviceTimeZone}}"
  },
  {
    "type": "TEXT",
    "name": "deviceHeight",
    "displayName": "Device Height",
    "simpleValueType": true,
    "defaultValue": "{{argoidDeviceHeight}}"
  },
  {
    "type": "TEXT",
    "name": "deviceWidth",
    "displayName": "Device Width",
    "simpleValueType": true,
    "defaultValue": "{{argoidDeviceWidth}}"
  },
  {
    "type": "TEXT",
    "name": "devicePixelRatio",
    "displayName": "Device Pixel Ratio",
    "simpleValueType": true,
    "defaultValue": "{{argoidDevicePixelRatio}}"
  },
  {
    "type": "TEXT",
    "name": "deviceOsName",
    "displayName": "OS Name",
    "simpleValueType": true,
    "defaultValue": "{{argoidOsName}}"
  },
  {
    "type": "TEXT",
    "name": "deviceOsVersion",
    "displayName": "OS Version",
    "simpleValueType": true,
    "defaultValue": "{{argoidOsVersion}}"
  },
  {
    "type": "TEXT",
    "name": "pageView",
    "displayName": "Page Info",
    "simpleValueType": true,
    "defaultValue": "{{argoidPageView}}"
  },
  {
    "type": "TEXT",
    "name": "cartEvent",
    "displayName": "Cart Event Name",
    "simpleValueType": true,
    "defaultValue": "{{argoidCustomEvent}}"
  },
  {
    "type": "TEXT",
    "name": "cartData",
    "displayName": "Cart Data",
    "simpleValueType": true,
    "defaultValue": "{{argoidCartData}}"
  },
  {
    "type": "TEXT",
    "name": "cart_summery",
    "displayName": "Cart Summery",
    "simpleValueType": true,
    "defaultValue": "{{argoidCartSummery}}"
  },
  {
    "type": "TEXT",
    "name": "orderProduct",
    "displayName": "Product Ordered Details",
    "simpleValueType": true,
    "defaultValue": "{{argoidOrderProduct}}"
  },
  {
    "type": "TEXT",
    "name": "orderPlacedEvent",
    "displayName": "Order Placed",
    "simpleValueType": true,
    "defaultValue": "{{argoidOrderPlacedEvent}}"
  },
  {
    "type": "TEXT",
    "name": "templateVariable",
    "displayName": "Argoid Analytics Settings Imported Template Variable Name",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const argoidRestBaseUrl = data.templateVariable.appSettings.eventServerUrl;
const callInWindow = require("callInWindow");
const copyFromWindow = require("copyFromWindow");
const queryPermission = require("queryPermission");
const encodeUriComponent = require("encodeUriComponent");
const log = require("logToConsole");
const getTimestampMillis = require("getTimestampMillis");
const sendPixel = require("sendPixel");
const injectScript = require("injectScript");
const script_url =
  "https://storage.googleapis.com/common-scripts/basicMethods.js";
log("data =", data);
var eventServerRequestHeaders = [];
data.templateVariable.appSettings.eventServerAuthorization.forEach(function (
  serverAuth
) {
  log("serverAuth", serverAuth);
  if (serverAuth.enabled) {
    eventServerRequestHeaders.push(serverAuth.header);
  }
});
log("eventServerRequestHeaders", eventServerRequestHeaders);
log(
  "eventServerAuthorization",
  data.templateVariable.appSettings.eventServerAuthorization
);

let timestamp = getTimestampMillis().toString();
let categoryUrl = data.currentUrl;
const currentUrlSplit = data.currentUrl.split("/");
let collectionName = currentUrlSplit[4];
const deviceInfo = data.templateVariable.deviceInfo;

let browser = "null";
let nAgt = deviceInfo.browserUserAgent;
var verOffset, nameOffset;
// Opera
if ((verOffset = nAgt.indexOf("Opera")) != -1) {
  browser = "Opera";
}
// MSIE
else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
  browser = "Microsoft Internet Explorer";
}
// Chrome
else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
  browser = "Chrome";
}
// Safari
else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
  browser = "Safari";
}
// Firefox
else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
  browser = "Firefox";
}
// MSIE 11+
else if (nAgt.indexOf("Trident/") != -1) {
  browser = "Microsoft Internet Explorer";
}
// Other browsers
else if (
  (nameOffset = nAgt.lastIndexOf(" ") + 1) < (verOffset = nAgt.lastIndexOf("/"))
) {
  browser = nAgt.substring(nameOffset, verOffset);
}

function isObjectEmpty(obj) {
  if (
    obj == "undefine" ||
    obj == "undefined" ||
    obj == "null" ||
    obj == undefined ||
    obj == null ||
    obj == " "
  ) {
    return true;
  }
  return false;
}

log("anonymousId =", data.templateVariable.user.gaId);
log("registeredUserId =", data.templateVariable.user.userId);
log("appId =", data.templateVariable.appSettings.appId);
log("appSource =", data.templateVariable.appSettings.appSource);
log("eventTimestamp =", timestamp);
log("deviceIP =", deviceInfo.ipAddress);
log("latitude =", deviceInfo.latitude);
log("longitude =", deviceInfo.longitude);
log("deviceTimeZone =", deviceInfo.deviceTimeZone);
log("deviceOsName =", deviceInfo.deviceOsName);
log("OsVersion =", deviceInfo.deviceOsVersion);
log("browser =", browser);
log("networkType =", deviceInfo.networkType);
log("devicePixelRatio =", deviceInfo.devicePixelRatio);
log("connectionSpeed =", deviceInfo.connectionSpeed);
log("language =", deviceInfo.language);
log("deviceHeight =", deviceInfo.deviceHeight);
log("deviceWidth =", deviceInfo.deviceWidth);
log("appVersion =", data.templateVariable.appSettings.appVersion);
log("sdkVersion =", data.templateVariable.appSettings.sdkVersion);
log("themeId =", data.templateVariable.appSettings.themeId);
log("themeRole =", data.templateVariable.appSettings.themeRole);
log(
  "themeRole =",
  data.templateVariable.appSettings.optimizeExperimentVariantId
);

var optimizeExperimentVariantId =
  data.templateVariable.appSettings.optimizeExperimentVariantId;

var optimizeVariant = null;

// optimizeExperimentVariantId sample value GAX1.2.7G1YKFNFTaSXvtSomDKP8A.19048.0
// last value respresents variant
if (optimizeExperimentVariantId) {
  var optimizeVariantInt = optimizeExperimentVariantId.split(".").pop();
  optimizeVariant = optimizeVariantInt == 0 ? "ORIGINAL" : "ARGOID";
}

const FinalData = {
  sessionId: deviceInfo.sessionId,
  userIds: {
    anonymousId: data.templateVariable.user.gaId,
    registeredUserId: data.templateVariable.user.userId,
  },
  appId: data.templateVariable.appSettings.appId,
  appSource: data.templateVariable.appSettings.appSource,
  eventTimestamp: timestamp,
  eventType: "not defined",
  eventAttributes: "not defined",
  deviceAttributes: {
    deviceIP: deviceInfo.ipAddress,
    latitude: deviceInfo.latitude,
    longitude: deviceInfo.longitude,
    deviceTimeZone: deviceInfo.deviceTimeZone,
    deviceOsName: deviceInfo.deviceOsName,
    OsVersion: deviceInfo.deviceOsVersion,
    browser: browser,
    networkType: deviceInfo.networkType,
    devicePixelRatio: deviceInfo.devicePixelRatio + "", // converting to string ,processing pipeline has some issue in parquet format
    connectionSpeed: deviceInfo.connectionSpeed,
    language: deviceInfo.language,
    deviceHeight: deviceInfo.deviceHeight,
    deviceWidth: deviceInfo.deviceWidth,
    deviceId: "1355435835494",
  },
  clientAttributes: {
    appVersion: data.templateVariable.appSettings.appVersion,
    sdkVersion: data.templateVariable.appSettings.sdkVersion,
    themeId: data.templateVariable.appSettings.themeId,
    themeRole: data.templateVariable.appSettings.themeRole,
    optimizeExperimentVariantId: optimizeExperimentVariantId,
    optimizeVariant: optimizeVariant,
  },
  additionalMetadata: { status: "SUCCESS" },
};

function sendingDataToServer(source) {
  log("calling injectingScript , source = ",source);
  if (queryPermission("inject_script", script_url)) {
    injectScript(
      script_url,
      () => {
        log("sending events to  server");
        var sentFnReturnVal = callInWindow(
          "sendRequest",
          "POST",
          argoidRestBaseUrl,
          FinalData,
          eventServerRequestHeaders
        );
      },
      (err) => {
        log("error while injecting script", err);
      }
    );
  } else {
    log("not injecting Script");
  }
}

function validatingViewCollectionData() {
  var errors = [];

  if (
    isObjectEmpty(FinalData.userIds.anonymousId) &&
    isObjectEmpty(FinalData.userIds.registeredUserId)
  ) {
    errors.push("Unable to anonymousId / registeredUserId");
  }
  if (isObjectEmpty(collectionName)) {
    errors.push("Unable to get the collectionName");
  }

  if (errors.length >= 1) {
    FinalData.additionalMetadata = { status: "FAILURE", errors: errors };
  }
}
function validatingAddToCartData() {
    log("validating cart data");
  var errors = [];

  if (
    isObjectEmpty(FinalData.userIds.anonymousId) &&
    isObjectEmpty(FinalData.userIds.registeredUserId)
  ) {
    errors.push("Unable to anonymousId / registeredUserId");
  }

  if (isObjectEmpty(data.templateVariable.cart.addToCardObj)) {
    errors.push("Unable to get the Added Cart Data");
  } else if (
    isObjectEmpty(data.templateVariable.cart.addToCardObj.lineItems) ||
    isObjectEmpty(
      data.templateVariable.cart.addToCardObj.lineItems[0].quantity
    ) ||
    (isObjectEmpty(
      data.templateVariable.cart.addToCardObj.lineItems[0].productGroupId
    ) &&
      isObjectEmpty(
        data.templateVariable.cart.addToCardObj.lineItems[0].productVariantId
      ))
  ) {
    if (isObjectEmpty(data.templateVariable.cart.addToCardObj.lineItems)) {
      errors.push("Unable to get the lineItems");
    }
    if (
      isObjectEmpty(
        data.templateVariable.cart.addToCardObj.lineItems[0].quantity
      )
    ) {
      errors.push("Unable to get the lineItems 0 quantity");
    }
    if (
      isObjectEmpty(
        data.templateVariable.cart.addToCardObj.lineItems[0].productGroupId
      ) &&
      isObjectEmpty(
        data.templateVariable.cart.addToCardObj.lineItems[0].productVariantId
      )
    ) {
      errors.push(
        "Unable to get the lineItems 0  productGroupId or productVariantId"
      );
    }
  }
  if (errors.length >= 1) {
    FinalData.additionalMetadata = { status: "FAILURE", errors: errors };
  }
}
function validatingCartSummaryData() {
  var errors = [];

  if (
    isObjectEmpty(FinalData.userIds.anonymousId) &&
    isObjectEmpty(FinalData.userIds.registeredUserId)
  ) {
    errors.push("Unable to anonymousId / registeredUserId");
  }
  if (isObjectEmpty(data.templateVariable.cart.cartSummaryObj)) {
    errors.push("Unable to get the cart summary data");
  } else if (
    isObjectEmpty(data.templateVariable.cart.cartSummaryObj.lineItems)
  ) {
    errors.push("Unable to get the lineItems");
  } else {
    var i;

    for (
      i = 0;
      i < data.templateVariable.cart.cartSummaryObj.lineItems.length;
      i++
    ) {
      if (
        isObjectEmpty(
          data.templateVariable.cart.cartSummaryObj.lineItems[i].quantity
        )
      ) {
        errors.push("Unable to get the lineItems " + i + " quantity");
      }
      if (
        isObjectEmpty(
          data.templateVariable.cart.cartSummaryObj.lineItems[i].productGroupId
        ) &&
        isObjectEmpty(
          data.templateVariable.cart.cartSummaryObj.lineItems[i]
            .productVariantId
        )
      ) {
        errors.push(
          "Unable to get the lineItems " +
            i +
            " productGroupId or productVariantId"
        );
      }
    }
  }

  if (errors.length >= 1) {
    FinalData.additionalMetadata = { status: "FAILURE", errors: errors };
  }
}

function validatingOrderProductData() {
  var errors = [];

  if (
    isObjectEmpty(FinalData.userIds.anonymousId) &&
    isObjectEmpty(FinalData.userIds.registeredUserId)
  ) {
    errors.push("Unable to anonymousId / registeredUserId");
  }
  if (isObjectEmpty(data.templateVariable.order.orderInfoObj)) {
    errors.push("Unable to get the order data");
  } else if (
    isObjectEmpty(data.templateVariable.order.orderInfoObj.lineItems)
  ) {
    errors.push("Unable to get the lineItems");
  } else {
    var i;

    for (
      i = 0;
      i < data.templateVariable.order.orderInfoObj.lineItems.length;
      i++
    ) {
      if (
        isObjectEmpty(
          data.templateVariable.order.orderInfoObj.lineItems[i].quantity
        )
      ) {
        errors.push("Unable to get the lineItems " + i + " quantity");
      }
      if (
        isObjectEmpty(
          data.templateVariable.order.orderInfoObj.lineItems[i].productGroupId
        ) &&
        isObjectEmpty(
          data.templateVariable.order.orderInfoObj.lineItems[i].productVariantId
        )
      ) {
        errors.push(
          "Unable to get the lineItems " +
            i +
            " productGroupId or productVariantId"
        );
      }
    }
  }
  if (errors.length >= 1) {
    FinalData.additionalMetadata = { status: "FAILURE", errors: errors };
  }
}

let pageView = data.templateVariable.pageView.pageViewEvent;
if (
  pageView == "View Product" &&
  data.templateVariable.cart.cartEvent != "gtm.pageError" &&
  data.templateVariable.cart.cartEvent != "cart_summery" &&
  data.templateVariable.cart.cartEvent != "argoid_add_to_cart" &&
  !data.templateVariable.sectionClick.sectionName
) {
  const viewProductData = {
    productGroupId: data.templateVariable.pageView.productPage.productId,
    sourcePageUrl: data.templateVariable.pageView.sourcePageUrl,
  };
  FinalData.eventAttributes = viewProductData;
  FinalData.eventType = "VIEW_PRODUCT";
  log("Sending VIEW_PRODUCT event");
  log(data.templateVariable.pageView.sourcePageUrl);
  sendingDataToServer("VIEW_PRODUCT");
}

if (data.templateVariable.sectionClick.sectionName) {
  const clickProduct = {
    productHandle: data.templateVariable.sectionClick.productHandle,
    sourceSection: data.templateVariable.sectionClick.sectionName,
    // for click event current url is the source (origin ) of the event
    sourcePageUrl: data.templateVariable.pageView.currentUrl,
    sourceIndex: data.templateVariable.sectionClick.sectionIndex,
  };
  FinalData.eventAttributes = clickProduct;
  FinalData.eventType = "CLICK_PRODUCT";
  log("Sending CLICK_PRODUCT event");
  // TODO Add Validation
  sendingDataToServer("CLICK_PRODUCT");
  log("Sent CLICK_PRODUCT event");
}

if (data.templateVariable.collectionClick.sectionName) {
  const clickProduct = {
    collectionHandle: data.templateVariable.collectionClick.collectionHandle,
    sourceSection: data.templateVariable.collectionClick.sectionName,
    // for click event current url is the source (origin ) of the event
    sourcePageUrl: data.templateVariable.pageView.currentUrl,
  };
  FinalData.eventAttributes = clickProduct;
  FinalData.eventType = "CLICK_CATEGORY";
  log("Sending CLICK_CATEGORY event");
  // TODO Add Validation
  sendingDataToServer("CLICK_CATEGORY");
  log("Sent CLICK_CATEGORY event");
}

if (pageView == "View Collections" &&
  data.templateVariable.cart.cartEvent != "gtm.pageError") {
  const viewCollectionsData = {
    categoryId: collectionName,
    sourcePageUrl: data.templateVariable.pageView.sourcePageUrl,
    categoryUrl: data.templateVariable.pageView.currentUrl,
    sourceIndex: data.templateVariable.pageView.collectionPage.sourceIndex,
  };
  FinalData.eventAttributes = viewCollectionsData;
  FinalData.eventType = "VIEW_CATEGORY";
  validatingViewCollectionData();
  sendingDataToServer("VIEW_CATEGORY");
}

log("cartdata =", data.templateVariable.cart.addToCardObj);
log("cart_summery =", data.templateVariable.cart.cartSummaryObj);
log("cartEventName =", data.templateVariable.cart.cartEvent);
log("orderProduct =", data.templateVariable.order.orderInfoObj);
log("thankYouPage =", data.templateVariable.order.argoidOrderPlacedEvent);
if (data.templateVariable.cart.cartEvent == "argoid_add_to_cart") {
  log("argoid ADD_PRODUCT_TO_CART start");
  FinalData.eventAttributes = data.templateVariable.cart.addToCardObj;
  FinalData.eventType = "ADD_PRODUCT_TO_CART";
  validatingAddToCartData();
  sendingDataToServer("ADD_PRODUCT_TO_CART");
  log("argoid ADD_PRODUCT_TO_CART end");
}

if (data.templateVariable.cart.cartEvent == "cart_summery") {
  FinalData.eventAttributes = data.templateVariable.cart.cartSummaryObj;
  FinalData.eventType = "CART_SUMMARY";
  log("argoid CART_SUMMARY start");
  validatingCartSummaryData();

  sendingDataToServer("CART_SUMMARY");
  log("argoid CART_SUMMARY end");
}

if (data.templateVariable.order.argoidOrderPlacedEvent == "Order Placed") {
  log("order placed start");
  FinalData.eventAttributes = data.templateVariable.order.orderInfoObj;
  FinalData.eventType = "ORDER_PRODUCT";

  validatingOrderProductData();

  sendingDataToServer("ORDER_PRODUCT");
  log("order placed end");
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.free.beeceptor.com/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "sendPOST.sendEvent"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "sendRequest"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://storage.googleapis.com/common-scripts/basicMethods.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Quick Test
  code: runCode();
setup: ''


___NOTES___

Created on 27/09/2021, 13:45:34


