<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div key=1 class="card" v-if='!loading'>
            <div class="card-header">
              <h6>Задача № {{ task.id }} от {{ user.name }} {{ task.date_of_detection }}</h6>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-12">
                  <h5 class="section-semi-title">Медиа файлы</h5>
                  <vue-dropzone id="drop1" :options="config" @vdropzone-complete="afterComplete" ref="myVueDropzone"></vue-dropzone>
                </div>
                <div class="col-md-4">
                  <h5 class="section-semi-title">Дата выявления</h5>
                  <datepicker input-class="form-control" v-model="task.date_of_detection" placeholder="Select Date"/>
                </div>
              </div>
            </div>
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
import vue2Dropzone from 'vue2-dropzone'
import Datepicker from 'vuejs-datepicker'
export default {
  data () {
    return {
      'header': 'header',
      count: 1,
      task: {},
      user: {},
      loading: true,
      config: {
        url: "http://clean-crm/api/taskfile",
      }
    }
  },
  components: {
    vueDropzone: vue2Dropzone,
    Datepicker,
  },
  created() {
    console.log(this.$route.params.id)
    this.getTask(this.$route.params.id)
    var file = { size: 123, name: "Icon", type: "image/png" };
    var url = "https://cdn.vox-cdn.com/thumbor/Pkmq1nm3skO0-j693JTMd7RL0Zk=/0x0:2012x1341/1200x800/filters:focal(0x0:2012x1341)/cdn.vox-cdn.com/uploads/chorus_image/image/47070706/google2.0.0.jpg";
    this.$refs.myVueDropzone.manuallyAddFile(file, url);
  },
  methods: {
    afterComplete(file) {
      console.log(file);
    },
    async getTask (id) {
      let response = await window.axios.post('/api/admin/task/view/' + id)
      let userResponse = await window.axios.post('/api/admin/profile')
      this.task = response.data
      this.user = userResponse.data
      console.log(userResponse)
      this.loading = false
    },
    AddFile () {
      let file = { size: 123, name: 'Icon' }
      let url = '/assets/img/demo/gallery/' + this.count + '.jpg'
      this.$refs.myVueDropzone.manuallyAddFile(file, url)
      if (this.count !== 12) {
        this.count = this.count + 1
      } else {
        this.count = 12
      }
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