# faceAttend
##### ![alt text](https://challengepost-s3-challengepost.netdna-ssl.com/photos/production/software_photos/000/799/034/datas/original.jpeg)
####  ![alt text](https://challengepost-s3-challengepost.netdna-ssl.com/photos/production/software_photos/000/799/074/datas/original.jpeg)
## ![alt text](https://challengepost-s3-challengepost.netdna-ssl.com/photos/production/software_photos/000/799/049/datas/original.jpeg)
## ![alt text](https://challengepost-s3-challengepost.netdna-ssl.com/photos/production/software_photos/000/799/063/datas/original.jpeg)

## Inspiration
We wanted to tackle a challenging problem that we face during class, and a problem that makes lives a lot harder for new or substitute teachers. We tried our best to create something that would take something very simple and bring it to the 21st century.

## What it does
Our application uses Azure implemented with artificial intelligence to create a custom face id that allows you to take a photo of yourself, and upon taking the photo it will compare the photo to the ones stored in our firebase database. This will allow us to use Azure (which implements ai) to decide whether you are in the class and you are recognized or whether you aren't in the class and are an unknown person. We also implemented a class contact book, that the teacher and other students can see. The contact book includes a photo of the person, their name, attendance status, and a contact button, which when pressed gives you the email, and phone number of the person. Furthermore, you get the ability to call them.

## How we built it
We used swift (the iOS platform coding language) to create this project. In order to create the custom face id, we used Azure by Microsoft. Furthermore, we used firebase to store the images which we use to compare your scanned face with.

## Challenges we ran into
One main challenge was being able to download the image from firebase and send it through the Azure custom face id to check whether the faces are a match or not. We solved this problem through a lot of trial and error, by casting the image into different types, we finally found a type that matched what the face id required.

## Accomplishments that we're proud of
One major accomplishment that we are proud of would be the fact that we were able to send images into the Azure network to compare with our stored images in firebase.

## What we learned
We learned how to handle AI, calls to APIs and we learned how to use the camera delegate to access the front-facing camera to take a snapshot of the face. We also learned how to download images from firebase storage to use for our comparison.


## What's next for FaceAttend
In the future, for FaceAttend, we would like to implement a location-based attendance system, where students will be prohibited from "attending" if they take their photo outside of a certain range with a fixed center point.
We would also like to combine this with schoolloop or other grade storing apps to create a seamless connection with how you get into school, how you communicate with your peers, and how you are able to track your educational progress.


