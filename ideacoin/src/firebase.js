import * as firebase from 'firebase/app'
import 'firebase/auth'

// firebase init - add your own config here
const firebaseConfig = {
    apiKey: "AIzaSyBVTZCpllh-OT94LiE-PsYHjuCy40dw3ds",
    authDomain: "idea-e44c6.firebaseapp.com",
    projectId: "idea-e44c6",
    storageBucket: "idea-e44c6.appspot.com",
    messagingSenderId: "923557435881",
    appId: "1:923557435881:web:ceb2c6eff125c11bb91378"
}
firebase.initializeApp(firebaseConfig)

// utils
const auth = firebase.auth()

// export utils/refs
export {
  auth
}