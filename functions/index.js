const functions = require('firebase-functions');
const admin = require('firebase-admin');
const {
  snapshotConstructor,
} = require('firebase-functions/lib/providers/firestore');

admin.initializeApp();

exports.onCreateChatMessage = functions.firestore
  .document('chat/{messaage}')
  .onCreate((snapshot, context) => {
    return admin.messaging().sendToTopic('chat', {
      notification: {
        title: snapshot.data().username,
        body: snapshot.data().text,
        clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      },
    });
  });
