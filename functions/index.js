
//  I wrote
const functions=require("firebase-functions");
const admin=require("firebase-admin");


admin.initializeApp();
// Create a reference to the database
const db = admin.firestore();

/* eslint-disable max-len */
exports.sendBirthdayNotification = functions.pubsub.schedule("every 2 minutes").onRun(async (context) =>{
  const todos = [];
  // Query all documents in any subcollection named PersonalData, friends, family or pets
  const querySnapshot = await db.collectionGroup("PersonalData").get();
  // Loop through the results and push them to the array
  querySnapshot.forEach((doc) => {
    todos.push(doc.data());
  });

  // Get the current date
  const today = new Date();

  // Convert it to a string format of DD/MM/YYYY
  const formattedDate = today.toLocaleDateString("en-GB", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });

  todos.forEach((todo) => {
    // Check if the document has the date of birth field
    if (Object.prototype.hasOwnProperty.call(todo, "dateOfBirth")) {
      // Get the date of birth from the document
      const dob = todo.dateOfBirth;

      // Compare the two dates and log a message if they are equal
      if (formattedDate === dob) {
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
      }
    }
  });
});

