import { request } from 'http';
import { ref } from 'firebase-functions/lib/providers/database';

const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
exports.addMessage = functions.https.onRequest((req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into the Realtime Database using the Firebase Admin SDK.
    return admin.database().ref('/messages').push({original: original}).then((snapshot) => {
      // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
      return res.redirect(303, snapshot.ref);
    });
  });

//Values to Query for: Department, Teacher }}} KEYS!!!!

// exports.searchDatabaseDepartment = functions.https.onRequest((req,res) => {

//   const querySearch = req.query.term;
//   const queryValue = req.query.query;  
//   const nested = req.query.nested;

//   var x;
//   ref = ref = admin.database().ref('/forms')
//   ref.on("value",function(snapshot){
//     // x = ref.orderbyKey(querySearch).equalTo(queryValue);
//     x = snapshot.orderbyKey(querySearch);
//     console.log(x) 
//   });
//   res.json(200,x)
// });

exports.getSubsitituteForms = functions.https.onRequest((req,res) =>{


  // refAdmin = admin.database().ref('/adminUID')
  // refSub = admin.database().ref('/subUID')
  ref = admin.database().ref('/');
  const UID = req.query.UID;
  //Check UID for ADMIN acccess

  ref.on("value",function(snapshot){
        // x = ref.orderbyKey(querySearch).equalTo(queryValue);
        if(snapshot.child('adminUID').hasChild(UID)){
          //THE SIGNED USER IS A ADMIN

          res.json("ADMIN");
          // res.json(snapshot.child('forms'));
          //RETURN ALL FORMS
        }
        else if(snapshot.child('subUID').hasChild(UID)){
          //THE SIGNED USER IS A SUBSTITUTE
          res.json("SUBSTITUTE");
          //SEARCH UID FOR CORRESPODING FORMS
          //RETURN CORRESPONDING FORMS

        }
  });



});





exports.searchDatabaseQuery = functions.https.onRequest((req, res) => {

  //REDESIGN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  //Parse the request for queries
  //INSERT THE TERM IN THE HTTPS REQUEST PARAM: 'searchKey'
  // const keyQuery = req.query.searchKey;
  //ALL RESULTS ARE 'PUSH'ED HERE
  
  //Department,Teacher, Reasons, Substitute, Date Sumbitted, 
  
  //Work with KeyQuery to parse through the snapshot and compile seperate JSON file
  /*
  Forms
    - Form ID 1(req.child())
      - Date 1
        - Department:
      - Date 2
        - Department:
      - Substitute:  
    - Form ID 2
      - Date 1
        - Department:
      - Date 2
        - Department:
  */
    // var result = {};
    // ref = admin.database.ref('/forms')
    // ref.once("value")
    // .then(function(snapshot) {
    //   var a = snapshot.hasChildren()
    //   res.send(200,"HELLO IM TESTING")
    // });
  //RESPONSE SENDS JSON DATA
  //ref = Database Reference
  const querySearch = req.query.term;
  const queryValue = req.query.query;  
  const nested = req.query.nested;

  ref = admin.database().ref('/forms')
  ref.on("value", function(snapshot){
    var x = [];
    if(nested == 'true')
    {
      snapshot.forEach(function(childSnapshot) {
        // key will be "ada" the first time and "alan" the second time
        var key = childSnapshot.key;
        // childData will be the actual contents of the child
        var childData = childSnapshot.val();
        childSnapshot.forEach(function(child2Snapshot) {
  
            if(child2Snapshot.hasChildren()){
              // x = child2Snapshot.child('department').val()
              if(child2Snapshot.child(querySearch).val() == queryValue){
                // x += childData
                // x = childData
                // x = (typeof(childData)).toString()
                // x.push(childSnapshot.key,childSnapshot.toJSON())
                x.push({
                  key:   childSnapshot.key,
                  value: childSnapshot.toJSON()
                });
                // res.json(200,x)
                // x = queryDepartment
                // x = "ITS ENGLISH"
              }
            }
  
          // return true
        });
    }); 
    }
    else if(nested == 'false'){
      snapshot.forEach(function(childSnapshot) {
        // key will be "ada" the first time and "alan" the second time
        var key = childSnapshot.key;
        // childData will be the actual contents of the child
        var childData = childSnapshot.val();
        // childSnapshot.forEach(function(child2Snapshot) {
            // if(child2Snapshot.hasChildren() == false){
              // x = child2Snapshot.child('department').val()
              console.log(childSnapshot.child(querySearch))
              if(childSnapshot.child(querySearch).val() == queryValue){
                console.log("FOUND A MATCH LETS GOOO")
                // x += childData
                // x = childData
                // x = (typeof(childData)).toString()
                // x.push(childSnapshot.key,childSnapshot.toJSON())
                x.push({
                  key:   childSnapshot.key,
                  value: childSnapshot.toJSON()
                });
                // res.json(200,x)
                // x = queryDepartment
                // x = "ITS ENGLISH"
              }
            // }
          // return true
        // });
    });


    }
    

    res.json(200, x)
    // res.json({name: 'Sahil'})
  });
  
exports.databaseUpdate = functions.database.ref('/forms').onWrite((event) => {
    // const email = 'zhangr@rutgersprep.org';
    // const displayName = 'Ray';
    // return sendEmail(email, displayName); 
    /* SEND EMAIL */
    //
    /* Number Generator */
    // ref = 

    ref.on("value",function(snapshot){
      
            const formNumber = snapshot.child('form_num_gen').val();
            // x = ref.orderbyKey(querySearch).equalTo(queryValue);
            //Works returns value!!!!!!
            console.log("THE NEW FORM NUMBER IS>>>>" + (formNumber +1));
      
            
            snapshot.ref.update({"form_num_gen": formNumber + 1});
      
      
    });


});

  

});

 