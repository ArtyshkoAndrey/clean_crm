<template>
  <form @submit.prevent="validateBeforeSubmit">
    <div :class="['form-group', {'is-invalid': $v.registerData.name.$error}]">
      <input
        :class="{'is-invalid': $v.registerData.name.$error, 'form-group--loading': $v.registerData.name.$pending}"
        v-model.trim.lazy="registerData.name"
        class="form-control"
        placeholder="Имя"
        type="text"
        @change="$v.registerData.name.$touch()"
      >
      <span v-if="!$v.registerData.name.required" class="invalid-feedback">
        Name is required.
      </span>
    </div>
    <div :class="['form-group', {'is-invalid': $v.registerData.email.$error}]">
      <input
        :class="{'is-invalid': $v.registerData.email.$error, 'form-group--loading': $v.registerData.email.$pending}"
        v-model.trim.lazy="registerData.email"
        class="form-control"
        placeholder="Enter Email"
        type="email"
        @change="$v.registerData.email.$touch()"
      >
      <span v-if="!$v.registerData.email.required" class="invalid-feedback">
        Email is required.
      </span>
      <span v-if="!$v.registerData.email.email" class="invalid-feedback">
        Please verify your email.
      </span>
      <span v-if="!$v.registerData.email.isUnique" class="invalid-feedback">
        This email is already registered.
      </span>
    </div>
    <div :class="['form-group', {'is-invalid': $v.registerData.password.$error}]">
      <input
        :class="{ 'is-invalid': $v.registerData.password.$error }"
        v-model.trim="registerData.password"
        class="form-control"
        placeholder="Enter Password"
        type="password"
        @change="$v.registerData.password.$touch()"
      >
      <span v-if="!$v.registerData.password.required" class="invalid-feedback">
        Password is required.
      </span>
      <span v-if="!$v.registerData.password.minLength" class="invalid-feedback">
        Password must have at least {{ $v.registerData.password.$params.minLength.min }} letters.
      </span>
    </div>
    <div :class="['form-group', {'is-invalid': $v.registerData.password_confirmation.$error}]">
      <input
        :class="{ 'is-invalid': $v.registerData.password_confirmation.$error }"
        v-model.trim="registerData.password_confirmation"
        class="form-control"
        placeholder="Retype Password"
        type="password"
        @change="$v.registerData.password_confirmation.$touch()"
      >
      <span v-if="!$v.registerData.password_confirmation.sameAsPassword" class="invalid-feedback">
        Passwords must be identical.
      </span>
    </div>
    <button class="btn btn-login btn-full">Создать аккаунт</button>
  </form>
</template>
<script type="text/babel">
import Auth from '../../services/auth'
import {required, minLength, email, sameAs} from 'vuelidate/lib/validators'

export default {
  data () {
    return {
      registerData: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  },
  validations: {
    registerData: {
      password: {
        required,
        minLength: minLength(6)
      },
      password_confirmation: {
        sameAsPassword: sameAs('password')
      },
      email: {
        required,
        email,
        async isUnique (value) {
          // standalone validator ideally should not assume a field is required
          if (value === '') return true

          // simulate async call, fail for all logins with even length
          let response = await window.axios.post('/api/email-exist', { email: value })
          return response.data
        }
      },
      name: {
        required
      }
    }
  },
  methods: {
    async validateBeforeSubmit () {
      this.$v.$touch()
      if (!this.$v.$error) {
        let response = await window.axios.post('/api/auth/register', this.registerData)
        console.log(response)
        if (response.data.registered) {
          window.toastr['success']('Вы зарегистрировались', 'Выполнено')
          this.$router.push({name: 'login'})
        } else {
          window.toastr['error']('Вы не зарегистрировались', 'Ошибка')
        }
      }
    }
  }
}
</script>
