<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Все пользователи</h3>
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
              <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th scope="col">№</th>
                      <th scope="col">ФИО</th>
                      <th scope="col">Email</th>
                      <th scope="col">Права</th>
                      <th scope="col">Действия</th>
                    </tr>
                  </thead>
                  <tbody v-if='users.length < 0'>
                    <tr>
                      <td colspan="5">Нет данных</td>
                    </tr>
                  </tbody>
                  <tbody v-else>
                    <tr v-for="user in users" :key="user.id">
                      <th scope="row">{{ user.id }}</th>
                      <td>{{ user.name }}</td>
                      <td>{{ user.email }}</td>
                      <td><span v-for='role in user.roles' :key='role.id'>{{ role.name }} <br></span></td>
                      <td>
                        <div class="btn-group" role="group">
                          <v-dropdown :show-arrow="false" theme-light>
                            <button
                              id="btnGroupDrop1"
                              slot="activator"
                              type="button"
                              class="btn btn-outline-default dropdown-toggle"
                              data-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                            >
                            </button>
                            <v-dropdown-item>
                              <button class="dropdown-item" @click='$router.push({ name: "userView", params: { id: user.id }})'>
                                Просмотреть
                              </button>
                            </v-dropdown-item>
                            <v-dropdown-item>
                              <button class="dropdown-item" @click='$router.push({ name: "userEdit", params: { id: user.id }})'>
                                Редактировать
                              </button>
                            </v-dropdown-item>
                            <v-dropdown-item>
                              <button class="dropdown-item">
                                Удалить
                              </button>
                            </v-dropdown-item>
                          </v-dropdown>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
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
      users: [],
      loading: true
    }
  },
  components: {
    Multiselect
  },
  mounted () {
    this.fetching()
  },
  methods: {
    async fetching () {
      await window.axios.get('/api/admin/user')
        .then(response => {
          console.log(response.data.users)
          response.data.status === 'success' ? this.users = response.data.users : window.toastr['error']('Ошибка сервера', 'Загрузка пользователей')
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
button.dropdown-item {
  color: black !important
}
</style>