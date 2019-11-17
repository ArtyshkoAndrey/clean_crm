<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div key=1 class="card" v-if='!loading'>
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h6 class="font-weight-bold d-flex h-100">Задача №{{ task.id }} - {{ task.name }}</h6>
                <transition name="fade" mode="out-in">
                  <button key=1 @click="mode='write'" v-if="mode === 'read'" class="btn-sm btn btn-warning">Изменить</button>
                </transition>
              </div>
            </div>
            <transition name="fade" mode="out-in">
              <Write
                key='write'
                v-if='mode === "write"'
                :rewriteTask='rewriteTask'
                :task='task'
                :user='user'
                :allUsers='allUsers'
                :responsibleList='responsibleList'
                :identifiedList='identifiedList'
                :type="'update'"
                @save='onSave'
              >
              </Write>
              <Read
                key='read'
                v-else
                :task='rewriteTask'
              >
              </Read>
            </transition>
          </div>
          <div key=2 class="card" v-else>
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
        url: "http://clean-crm/api/taskfile",
        thumbnailWidth: null,
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
    onSave() {
      this.mode === 'write' ? this.mode = 'read' : this.mode = 'write'
    },
    async getTask (id) {
      let response = await window.axios.post('/api/admin/task/view/' + id)
      let userResponse = await window.axios.post('/api/admin/profile')
      let identifiedResponse = await window.axios.post('/api/admin/usershelp')
      let responsibleResponse = await window.axios.post('/api/admin/responsibles')
      this.identifiedList = identifiedResponse.data
      this.responsibleList = responsibleResponse.data
      this.task = response.data
      this.user = userResponse.data
      this.rewriteTask = new Task(this.task)
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
</style>