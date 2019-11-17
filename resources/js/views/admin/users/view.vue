<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Просмотр данных пользователя</h3>
          </div>
          <transition name="fade" mode="out-in">
            <div v-if='loading' class="card-body" key=1>
              <div class="d-flex justify-content-center">
                <div class="spinner-grow text-primary" role="status">
                  <span class="sr-only">Loading...</span>
                </div>
              </div>
            </div>
            <div v-else class="card-body" key=2>
              <div class="row">
                <div class="col-12 mt-4">
                  <h6>ФИО пользователя: <strong>{{user.name}}</strong></h6>
                </div>
                <div class="col-12 mt-2">
                  <h6 class="pb-0 mb-0">Email:</h6>
                  <p class="mt-0 pt-0 lead">{{user.email}}</p>
                </div>
                <div v-if='user.profile && user.profile.birthday' class="col-12 mt-2">
                  <h6 class="pb-0 mb-0">Дата рождения</h6>
                  <p class="mt-0 pt-0 lead">{{ new Date(user.profile.birthday).toLocaleDateString() }}</p>
                </div>
                <div class="col-12 mt-2">
                  <h6 class="pb-0 mb-0">Роль (уровень доступа)</h6>
                  <p class="mt-0 pt-0 lead"><span v-for="role in user.roles" :key='role.id'>{{ role.name }} </span></p>
                </div>
                <div class="col-12 mt-2">
                  <h6 class="pb-0 mb-0">Отдел</h6>
                  <p class="mt-0 pt-0 lead">{{user.department}}</p>
                </div>
              </div>
            </div>
          </transition>
        </div>
			</div>
    </div>
  </div>
</template>

<script type="text/babel">
import Multiselect from 'vue-multiselect'

export default {
  data () {
    return {
      'header': 'header',
      user: {},
      loading: true
    }
  },
  components: {
    Multiselect
  },
  mounted () {
    this.fetching(this.$route.params.id)
  },
  methods: {
    async fetching (id) {
      await window.axios.get('/api/admin/user/' + id)
        .then(response => {
          console.log(response.data)
          response.data.status === 'success' ? this.user = response.data.user : window.toastr['error']('Ошибка сервера', 'Загрузка пользователей')
        })
        .catch(error => {
          console.error(error)
          window.toastr['error']('Ошибка сервера', 'Получение данных')
        })
        .finally(() => this.loading = false)
    }
  }
}
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
    transition: opacity .5s
}

.fade-enter,
.fade-leave-to {
    opacity: 0
}
</style>