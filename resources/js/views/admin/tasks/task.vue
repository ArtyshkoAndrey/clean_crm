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
                  <button key=2 @click="mode='read'" v-else-if="mode === 'write'" class="btn-sm btn btn-primary">Сохранить</button>
                </transition>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-md-4 mt-4">
                  <h5 class="section-semi-title">Навзавние проблемы</h5>
                  <input
                    type="text"
                    v-model="rewriteTask.name"
                    class="form-control"
                    placeholder="Название проблемы"
                    required
                  >
                </div>
                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Описание проблемы проблемы</h5>
                  <textarea
                    class="form-control"
                    v-model="rewriteTask.description"
                    placeholder="Описание"
                    rows="3"
                  />
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Улица</h5>
                  <multiselect
                    v-model="rewriteTask.street"
                    id="ajax"
                    placeholder="Название улицы"
                    :options="dataStreet"
                    :searchable="true"
                    :multiple="false"
                    @search-change="getStreet"
                    label="value"
                    :selectLabel="''"
                  >
                  </multiselect>
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Номер дома</h5>
                  <multiselect
                    v-model="rewriteTask.numberHome"
                    id="ajax"
                    placeholder="Номер дома"
                    :options="dataNumber"
                    :searchable="true"
                    :multiple="false"
                    @search-change="getNumberHome"
                    :selectLabel="''"
                  >
                  </multiselect>
                </div>
                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Кем выявлено</h5>
                  <multiselect
                    v-model="rewriteTask.identified"
                    :options="identifiedList"
                    :multiple="true"
                    placeholder="Кем выявлено"
                    :hide-selected="true"
                    label="name"
                    :selectLabel="''"
                    :searchable="true"
                    track-by="id"
                  />
                </div>
                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Ответсвенный</h5>
                  <multiselect
                    v-model="rewriteTask.responsible"
                    :options="responsibleList"
                    :hide-selected="true"
                    :selectLabel="''"
                    :taggable="true"
                    placeholder="Ответсвтенный"
                    @tag="addResponsibleTag"
                    track-by="name"
                    label="name"
                  />
                </div>
                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Ответсвенный исполнитель</h5>
                  <input
                    type="text"
                    class="form-control"
                    v-model="rewriteTask.responsibleExecutor"
                    placeholder="Ответственный исполнитель"
                    required
                  >
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Дата выявления</h5>
                  <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.dateOfDetection" placeholder="Select Date"/>
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Дата устранения</h5>
                  <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.correctionDate" placeholder="Select Date"/>
                </div>
                <div class="col-md-6 mt-4">
                  <h5 class="section-semi-title">Констролный срок</h5>
                  <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.targetDate" placeholder="Select Date"/>
                </div>
                <div class="col-md-12 mt-4">
                  <h5 class="section-semi-title">Проведенная работа</h5>
                  <textarea
                    class="form-control"
                    rows="3"
                    placeholder="Описание проведённой работы"
                    v-model="rewriteTask.conductedWork"
                  />
                </div>
                <div class="col-12 mt-4">
                  <h5 class="section-semi-title">Медиа файлы</h5>
                  <vue-dropzone id="drop1" :options="config" @vdropzone-complete="afterComplete" ref="myVueDropzone"></vue-dropzone>
                </div>
                <div class="col-12 mt-4 justify-content-center align-content-center d-flex">
                  <button class="btn btn-primary mr-1" @click="save">Сохранить</button>
                  <button class="btn btn-default ml-1" @click="$router.push({name: 'tasks'})">Отменить</button>
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
import VueSuggestions from 'vue-suggestions'
import Multiselect from 'vue-multiselect'
export default {
  data () {
    return {
      'header': 'header',
      rewriteTask: {
        id: null,
        street: {},
        dateOfDetection: null,
        numberHome: '',
        responsible: {},
        identified: [],
        name: '',
        description: '',
        targetDate: null,
        correctionDate: null,
        responsibleExecutor: '',
        conductedWork: '',
        images: []
      },
      mode: 'write',
      task: {},
      user: {},
      allUsers: [],
      loading: true,
      dataNumber: [],
      dataStreet: [],
      config: {
        url: "http://clean-crm/api/taskfile",
        thumbnailWidth: null,
      },
      responsibleList: [],
      identifiedList: []
    }
  },
  components: {
    vueDropzone: vue2Dropzone,
    Datepicker,
    VueSuggestions,
    Multiselect
  },
  created() {
    this.getTask(this.$route.params.id)    
  },
  methods: {
    async save () {
      console.log(this.task)
      console.log(this.rewriteTask)
      window.axios.put('/api/admin/task', this.rewriteTask)
      .then(response => {
        console.log(response)
      })
      .catch(error => {
        console.log(error)
      });
    },
    async addResponsibleTag (responsible) {
      // TODO: переделать создание тег, отправлять на сервер,
      // а потом уже с новый список принимать, по списку искать новый тег и его вставлять в v-model
      console.log(responsible)
      responsible = {
        id: Math.max.apply(Math, this.responsibleList.map(res => res.id)) + 1,
        name: responsible
      }
      window.axios.post('/api/admin/responsibles/create', responsible).then(res => {
        console.log(res)
        this.responsibleList.push(responsible)
        this.rewriteTask.responsible = responsible
      }).catch(error => {
        window.toastr['error']('Ошибка', 'Не выполнено')
      })
    },
    afterComplete(file) {
      console.log(file);
      try {
        let image = JSON.parse(file.xhr.response).image
        image.path = JSON.parse(image.path)
        this.rewriteTask.images.push(image)
      } catch (e) {
        console.warn(e)
      }
    },
    async getTask (id) {
      let response = await window.axios.post('/api/admin/task/view/' + id)
      let userResponse = await window.axios.post('/api/admin/profile')
      let identifiedResponse = await window.axios.post('/api/admin/users')
      let responsibleResponse = await window.axios.post('/api/admin/responsibles')
      console.log('task', response)
      console.log('user', userResponse)
      console.log('indent', identifiedResponse)
      console.log('res', responsibleResponse)
      this.identifiedList = identifiedResponse.data
      this.responsibleList = responsibleResponse.data
      this.task = response.data
      this.user = userResponse.data
      this.identifiedList.forEach(userApi => {
        this.task.identified.forEach((user) => {
          user.id === userApi.id ? this.rewriteTask.identified.push(userApi) : null
        })
      })
      this.responsibleList.forEach(responsibleApi => {
        this.task.responsible.id === responsibleApi.id ? this.rewriteTask.responsible = this.task.responsible : null
      })
      this.rewriteTask.street.value = this.task.street
      this.rewriteTask.numberHome = this.task.number_home
      this.rewriteTask.dateOfDetection = new Date(this.task.date_of_detection.slice(6, 10), parseInt(this.task.date_of_detection.slice(3, 5)) - 1, this.task.date_of_detection.slice(0, 2))
      this.rewriteTask.targetDate = new Date(this.task.target_date.slice(6, 10), parseInt(this.task.target_date.slice(3, 5)) - 1, this.task.target_date.slice(0, 2))
      this.task.correction_date ? this.rewriteTask.correctionDate = new Date(this.task.correction_date.slice(6, 10), parseInt(this.task.correction_date.slice(3, 5)) - 1, this.task.correction_date.slice(0, 2)) : null
      this.rewriteTask.name = this.task.name
      this.rewriteTask.description = this.task.description
      this.rewriteTask.images = this.task.images
      this.rewriteTask.id = this.task.id
      this.rewriteTask.responsibleExecutor = this.task.responsible_executor
      this.rewriteTask.conductedWork = this.task.conducted_work
      this.loading = false
      setTimeout(() => {
        console.log(this.rewriteTask.images)
        this.rewriteTask.images.forEach(image => {
          image.path = JSON.parse(image.path)
          console.log(image)
          this.$refs.myVueDropzone.manuallyAddFile({ type: image.path.type, size: image.path.size, name: image.path.name}, image.path.file);
        })
      }, 1000);
    },
    async getNumberHome (query) {
      console.log(this.rewriteTask.street + " " + query)
      window.axios.post('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address',
        { 
          query: query,
          locations: [
            {
              city: "Красноярск",
              street_fias_id: this.rewriteTask.street.data.street_fias_id
            }
          ],
          restrict_value: true
        },
        {
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token be33fe1fe0328828d9632c248dcad68166e62740",
            "X-Secret": "23c196abec29f8f3bafeb96f8be339c491a3bb77"
          }
        }
      ).then(res => {
        this.dataNumber = []
        res.data.suggestions.forEach(element => {
          this.dataNumber .push(element.value)
        });
        console.log(this.dataNumber)
      })
    },
    async getStreet (query) {
      window.axios.post('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address',
        { 
          query: query,
          locations: [
            {
              city: "Красноярск"
            }
          ],
          restrict_value: true
        },
        {
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Token be33fe1fe0328828d9632c248dcad68166e62740",
            "X-Secret": "23c196abec29f8f3bafeb96f8be339c491a3bb77"
          }
        }
      ).then(res => {
        this.dataStreet = []
        this.dataStreet = res.data.suggestions
        console.log(this.dataStreet)
      })
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