<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div key=1 class="card" v-if='!loading'>
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h3 class="d-flex h-100">Создание новой задачи</h3>
              </div>
            </div>
            <Write
            :rewriteTask='rewriteTask'
            :task='{}'
            :user='user'
            :allUsers='allUsers'
            :responsibleList='responsibleList'
            :identifiedList='identifiedList'
            :type="'create'"
            @save='onSave'
            >
            </Write>
          </div>
          <div key=2 class="card" v-else>
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
import Write from './task/write.vue'
import Read from './task/read.vue'
import Task from '../../../helpers/Task'
export default {
  data () {
    return {
      'header': 'header',
      rewriteTask: {},
      user: {},
      allUsers: [],
      loading: true,
      config: {
        url: "http://clean-crm/api/taskfile",
        thumbnailWidth: null
      },
      responsibleList: [],
      identifiedList: []
    }
  },
  components: {
    Write,
    Read
  },
  created() {
    this.getTask(this.$route.params.id)
  },
  methods: {
    async onSave() {
      await window.axios.post('/api/admin/task', this.rewriteTask)
      .then(response => {
        console.log(response)
        if (response.data === 'Success') {
          window.toastr['success']('Выполнено', 'Сохранено')
          this.$router.push({name: 'tasks'})
        } else {
          window.toastr['error']('Ошибка', 'Не выполнено')
        }
      })
      .catch(error => {
        console.log(error)
        window.toastr['error']('Ошибка', 'Не выполнено')
      })
      console.log('Save')
    },
    async getTask (id) {
      let userResponse = await window.axios.post('/api/admin/profile')
      let identifiedResponse = await window.axios.post('/api/admin/usershelp')
      let responsibleResponse = await window.axios.post('/api/admin/responsibles')
      this.identifiedList = identifiedResponse.data
      this.responsibleList = responsibleResponse.data
      this.user = userResponse.data
      let task = {
        user_id: this.user.id,
        name: '',
        streat: {
          value: ''
        },
        number_home: '',
        description: '',
        detection_date: null,
        responsible: null,
        target_date: null,
        correction_date: null,
        responsible_executor: '',
        conducted_work: '',
        identified: [
          this.user
        ],
        images: []
      }
      this.rewriteTask = new Task(task)
      this.loading = false
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
