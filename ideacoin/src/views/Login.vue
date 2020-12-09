<template>
  <div class="login">
      <div v-if="logged==0">
          <div v-if="switcher==0" class="create">
            <span>Register</span>
            <input v-model="email" type="text">
            <input v-model="password" type="password">
            <button @click="register" >Register</button>
            <span @click="switcher = 1" >Already have an account?</span>
          </div> 
          <div v-if="switcher==1" class="create">
            <span>Login</span>
            <input v-model="email" type="text">
            <input v-model="password" type="password">
            <button @click="login" >Login</button>
            <span @click="switcher = 0" >Want to sign in?</span>
          </div>
      </div>
      <div v-if="logged==1">
          <div class="create">
              <span>You are already logged in!</span>
              <br>
              your ID: {{ids}} <br>
              your Email: {{email}} <br>
              <br>
              <br>
              <router-link to="/patents">Go to patents page</router-link>
              <br>
              <br>
              <button @click="logout" >Log out</button>
          </div>
      </div>
  </div>
</template>

<script>
import { auth } from '@/firebase' 

export default {
  name: "Login",
  components: {},
  data() {
    return {
      logged: 0,
      switcher: 0,
      ids: '',
      email: '',
      password: ''
    };
  },
  methods: {
    async register() {
      auth.createUserWithEmailAndPassword(this.email, this.password)
      .then((user) => {
        console.log(user);
        console.log(auth.currentUser.uid);
        this.ids = auth.currentUser.uid;
        this.logged = 1;
      })
      .catch((error) => {
        var errorCode = error.code;
        var errorMessage = error.message;
        console.log(errorCode, errorMessage);
      });
      
    },
    async login() {
      auth.signInWithEmailAndPassword(this.email, this.password)
      .then((user) => {
        this.ids = auth.currentUser.uid;
        this.logged = 1;
        console.log(user);
      })
      .catch((error) => {
        var errorCode = error.code;
        var errorMessage = error.message;
        console.log(errorCode, errorMessage);
      });
    },
    logout() {
        this.logged = 0;
        auth.signOut().then(function() {
        }).catch(function(error) {
        console.log(error);
        });
    }
  },
  beforeMount() {
    let checking = auth.currentUser;
    if (checking!=null) {
        this.ids = checking.uid;
        this.email = checking.email;
        this.logged = 1;
    }
  }
}
</script>
