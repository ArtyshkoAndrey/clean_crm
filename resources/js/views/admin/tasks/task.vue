<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div v-if="!loading" key="1" class="card">
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h6 class="font-weight-bold d-flex h-100">Задача №{{ task.id }} - {{ task.name }}</h6>
                <transition name="fade" mode="out-in">
                  <button v-if="mode === 'read'" key="1" class="btn-sm btn btn-warning" @click="mode='write'">Изменить</button>
                </transition>
              </div>
            </div>
            <transition name="fade" mode="out-in">
              <Write
                v-if="mode === 'write'"
                key="write"
                :rewrite-task="rewriteTask"
                :task="task"
                :user="user"
                :all-users="allUsers"
                :responsible-list="responsibleList"
                :identified-list="identifiedList"
                :mode="'update'"
                @save="onSave"
              />
              <Read
                v-else
                key="read"
                :task="rewriteTask"
              />
            </transition>
          </div>
          <div v-else key="2" class="card">
            <div class="card-header">
              <h6>Загрузка</h6>
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
  components: {
    Write,
    Read
  },
  data () {
    return {
      'header': 'header',
      rewriteTask: {},
      mode: 'read',
      task: {},
      user: {},
      allUsers: [],
      loading: true,
      config: {
        url: 'http://clean-crm/api/taskfile',
        thumbnailWidth: null
      },
      responsibleList: [],
      identifiedList: []
    }
  },
  created () {
    this.getTask(this.$route.params.id)
  },
  methods: {
    onSave () {
      this.mode === 'write' ? this.mode = 'read' : this.mode = 'write'
    },
    async getTask (id) {
      await window.axios.get('/api/admin/task/' + id)
        .then(response => {
          if (response.data.status === 'Success') {
            this.responsibleList = response.data.responsibles
            this.identifiedList = response.data.users
            this.task = response.data.task
            this.user = window.user
            this.rewriteTask = new Task(this.task)
            this.loading = false
          } else {
            console.log(response.data)
            window.toastr['error']('Ошибка', 'Загрузка данных с сервера')
          }
        })
        .catch(error => {
          console.log(error)
          window.toastr['error']('Ошибка', 'Загрузка данных с сервера')
        })
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
</style>
