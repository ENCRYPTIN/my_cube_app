
// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
// const {logger} = require("firebase-functions");
// const {onRequest} = require("firebase-functions/v2/https");
// const {onDocumentCreated} = require("firebase-functions/v2/firestore");


//  I wrote
const functions=require("firebase-functions");
const admin=require("firebase-admin");

//  The Firebase Admin SDK to access Firestore.
//  const {initializeApp} = require("firebase-admin/app");
//  const {getFirestore} = require("firebase-admin/firestore");

admin.initializeApp();

// Gets a reference to Firebase Cloud Messaging
//  const messaging = admin.messaging();
/* eslint-disable max-len */
exports.sendBirthdayNotification = functions.pubsub.schedule("every 2 minutes").onRun(async (context) =>{
  // get fcm token from a const variable
  const fcmtoken="crHV_n5MQJmO9ZRpDbdRPE:APA91bG8VT_zQRYcN74IqhPMmBkOE48R_hoWcIwYrGckgcdhIojTmko_ECTsG_3VlJmZ0E7BCdJHWlPff4-6kTiTGrlGA60EqdNjiPPhSz0P87cFQVwn4f73ZsTTlROqQJTy1vh47Q2O";// eslint-disable-line max-len
  /* eslint-enable max-len */
  //  Create a payload for the notification
  const payload = {
    notification: {
      title: "Happy Birthday!",
      body: "Wish you all the best!",
    },
  };

  const message = {
    token: fcmtoken,
    notification: payload.notification,
  };
  // Send the notification using FCM

  admin.messaging().send(message)
      .then((response) => {
      // Response is a message ID string.
        console.log("Successfully sent message:", response);
      })
      .catch((error) => {
        console.log("Error sending message:", error);
      });
});

