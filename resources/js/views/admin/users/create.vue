<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div v-if="!loading" key="1" class="card">
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h3 class="d-flex h-100">Создание нового пользователя</h3>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-6 mt-1">
                  <h5 class="section-semi-title">ФИО пользователя</h5>
                  <input v-model="user.name" type="text" class="form-control" placeholder="ФИО пользователя" required>
                </div>
                <div class="col-md-6 mt-1">
                  <h5 class="section-semi-title">Email</h5>
                  <input v-model="user.email" type="text" class="form-control" placeholder="example@mail.ru" required>
                </div>
                <div class="col-md-6 mt-1">
                  <h5 class="section-semi-title">Пароль</h5>
                  <input v-model="user.password" class="form-control" type="password" placeholder="Пароль" required>
                </div>
                <div class="col-md-6 mt-1">
                  <h5 class="section-semi-title">Дата рождения</h5>
                  <datepicker v-model="user.profile.birthday" input-class="form-control" format="dd.MM.yyyy" placeholder="Выберите дату"/>
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Роль (уровень доступа)</h5>
                  <multiselect
                    :options="roles"
                    v-model="user.roles"
                    :selectLabel="''"
                    placeholder="Роль"
                    track-by="name"
                    label="name"
                  />
                </div>

                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Отдел</h5>
                  <multiselect
                    :options="departments"
                    :selectLabel="''"
                    v-model="user.profile.department"
                    placeholder="Ответственный"
                    track-by="name"
                    label="name"
                  />
                </div>
                <div class="col-12 mt-4 justify-content-center align-content-center d-flex">
                  <button class="btn btn-primary mr-1" @click="save()" >Сохранить</button>
                  <button class="btn btn-default ml-1" @click="$router.push({name: 'users'})">Отменить</button>
                </div>
              </div>
            </div>
          </div>
          <div v-else key="2" class="card">
            <div class="card-header">
              <h3>Загрузка</h3>
            </div>
            <div class="card-body">
              <div class="d-flex justify-content-center">
                <div class="spinner-grow text-primary" role="status">
                  <span class="sr-only">Loading...</span>
                </div>
              </div>
            </div>
          </div>
        </transition>
      </div>
    </div>
  </div>
</template>

<script type="text/babel">
import Datepicker from 'vuejs-datepicker'
import Multiselect from 'vue-multiselect'

export default {
  components: {
    Datepicker,
    Multiselect
  },
  data () {
    return {
      'header': 'header',
      user: {
        name: '',
        email: '',
        password: '',
        profile: {
          department: {},
          birthday: ''
        },
        roles: {}
      },
      roles: [],
      departments: [],
      loading: true
    }
  },
  computed: {
    validateCheck () {
      return !!(this.rewriteTask.name &&
        this.rewriteTask.description &&
        this.rewriteTask.street &&
        this.rewriteTask.numberHome &&
        this.rewriteTask.identified.length > 0 &&
        this.rewriteTask.responsible &&
        this.rewriteTask.detectionDate &&
        this.rewriteTask.targetDate)
    }
  },
  mounted () {
    this.fetch()
  },
  methods: {
    async save () {
      console.log(this.user)
      // this.user.profile.birthday = this.user.profile.birthday.toJSON().substr(0, 10)
      await window.axios.post('/api/admin/user', this.user)
        .then(response => {
          console.log(response)
          if (response.data.status === 'success') {
            window.toastr['success']('Данные пользователя ' + this.user.name, 'Успешно обновлено')
            this.$router.push({name: 'users'})
          } else {
            window.toastr['error']('Ошибка сохранения', 'Загрузка данных')
          }
        })
        .catch(error => {
          console.log(error)
          window.toastr['error']('Ошибка сервера', 'Получение данных')
        })
        .finally(() => console.log('saved'))
    },
    async fetch () {
      await window.axios.get('/api/admin/user')
        .then(response => {
          console.log(response)
          if (response.data.status === 'success') {
            this.roles = response.data.roles
            this.departments = response.data.departments
          } else {
            window.toastr['error']('Ошибка сервера', 'Загрузка данных')
          }
        })
        .catch(error => {
          console.error(error)
          window.toastr['error']('Ошибка сервера', 'Получение данных')
        })
        // eslint-disable-next-line no-return-assign
        .finally(() => this.loading = false)
    }
  }
}
</script>

<style scoped>
.fade-enter-active {
  transition: opacity .5s
}

.fade-enter,
.fade-leave-active {
  opacity: 0
}

.form-control[readonly] {
  background: #fff;
}
</style>
