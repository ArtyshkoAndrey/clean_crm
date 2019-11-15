<template>
  <div class="main-content page-profile">
    <div class="page-header">
      <h3 class="page-title">Профиль</h3>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/admin">Главная</a></li>
        <li class="breadcrumb-item"><a href="/admin/profile">Профиль</a></li>
        <li class="breadcrumb-item active">{{ user.name }}</li>
      </ol>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="card">
          <div class="card-body">
            <transition name="fade" mode="out-in">
              <div v-if="loading" class="d-flex justify-content-center">
                <div class="spinner-grow text-primary" role="status">
                  <span class="sr-only">Loading...</span>
                </div>
              </div>
              <tabs class="tabs-default" v-else>
                <tab id="profile" name="Профиль">
                  <div class="row">
                    <div class="col-sm-3">
                      <div class="avatar-container">
                        <img
                          :src="user.profile && user.profile.avatar? user.profile.avatar : '/images/profile/avatar.png'"
                          alt="Avatar"
                          class="img-fluid"
                        >
                      </div>
                    </div>
                    <div class="col-sm-9">
                      <h4>{{ user.name }}</h4>
                      <p class="detail-row"><i class="icon-fa icon-fa-birthday-cake"/>{{ user.profile ? new Date(user.profile.birthday).toLocaleDateString() : 'Не указано' }}</p>
                    </div>
                  </div>
                </tab>
                <tab id="profile-messages" name="Задачи">
                  <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque dolores omnis possimus commodi consequuntur esse, ea libero impedit enim aliquam qui mollitia odio totam autem atque, voluptatibus recusandae voluptatum voluptate?</p>
                </tab>
                 <tab id="edit" name="Редактирование">
                   <form class="form-horizontal">
                      <div class="form-group row">
                        <label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                          <input type="email" class="form-control" id="inputEmail" v-model='user.email' placeholder="Email">
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputName2" class="col-sm-2 col-form-label">Дата рождения</label>
                        <div class="col-sm-10">
                          <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="user.profile.birthday" placeholder="Дата рождения"/>
                        </div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <button type="submit" class="btn btn-danger">Сохранить</button>
                        </div>
                      </div>
                    </form>
                 </tab>
              </tabs>
            </transition>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { Tabs, Tab } from 'vue-tabs-component'
import Datepicker from 'vuejs-datepicker'
import Multiselect from 'vue-multiselect'
export default {
  components: {
    'tabs': Tabs,
    'tab': Tab,
    Datepicker,
    Multiselect
  },
  data() {
    return {
      user: {
        name: 'Загрузка'
      },
      loading: true,
    }
  },

  mounted() {
    this.getUser()
  },
  methods: {
    async getUser() {
      await window.axios.post('/api/admin/profile')
      .then(response => {
        console.log(response)
        this.user = response.data
        this.loading = false
      })
      .catch(error => {
        console.log(error)
        window.toastr['error']('Ошибка', 'Не выполнено')
      });
    }
  }
}
</script>

<style>
.fade-enter-active {
  transition: opacity .5s
}

.fade-enter,
.fade-leave-active {
  opacity: 0
}
</style>