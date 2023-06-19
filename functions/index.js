
//  I wrote
const functions=require("firebase-functions");
const admin=require("firebase-admin");


admin.initializeApp();
// Create a reference to the database
const db = admin.firestore();

/* eslint-disable max-len */
exports.sendBirthdayNotification = functions.pubsub.schedule("every 24 hours").onRun(async (context) =>{
  const todos = [];
  // Query all documents in any subcollection named PersonalData, friends, family or pets
  const querySnapshot = await db.collectionGroup("PersonalData").get();
  const querySnapshot2 = await db.collectionGroup("Friends").get();
  const querySnapshot3 = await db.collectionGroup("Family").get();
  const querySnapshot4 = await db.collectionGroup("Pets").get(); // Loop through the results and push them to the array
  querySnapshot.forEach((doc) => {
    todos.push(doc.data());
  });
  querySnapshot2.forEach((doc) => {
    todos.push(doc.data());
  });
  querySnapshot3.forEach((doc) => {
    todos.push(doc.data());
  });
  querySnapshot4.forEach((doc) => {
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
  // Remove the last 5 characters (the year and the slash) from the string
    // The result will be in the format of DD/MM
  const formattedDateWithoutYear = formattedDate.slice(0, -5);

  todos.forEach((todo) => {
    // Check if the document has the date of birth field
    if (Object.prototype.hasOwnProperty.call(todo, "dateOfBirth")) {
      // Get the date of birth from the document
      const dob = todo.dateOfBirth;
      const fcmtoken=todo.fcmtoken;
      // Remove the last 5 characters (the year and the slash) from the string
      // The result will be in the format of DD/MM
      const dobWithoutYear = dob.slice(0, -5);
      // Compare the two dates and log a message if they are equal
      if (formattedDateWithoutYear === dobWithoutYear) {
        // get fcm token from a const variable

        // try to do for every document in every collection


        // eslint-disable-line max-len
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

