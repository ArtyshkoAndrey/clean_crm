<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div key=1 class="card" v-if='!loading'>
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h3 class="d-flex h-100">Создание нового пользователя</h3>
              </div>
            </div>
            <div class="card-body">
							<div class="row">
                <div class="col-md-6 mt-1">
                    <h5 class="section-semi-title">ФИО пользователя</h5>
                    <input type="text" v-model="" class="form-control" placeholder="ФИО пользователя" required>
                </div>
                <div class="col-md-6 mt-1">
                    <h5 class="section-semi-title">Email</h5>
										<input type="text" v-model="" class="form-control" placeholder="example@mail.ru" required>
                </div>
								<div class="col-md-6 mt-4">
                    <h5 class="section-semi-title">Дата рождения</h5>
                    <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.detectionDate" placeholder="Select Date"/>
                </div>
                <div class="col-md-6 mt-4">
                    <h5 class="section-semi-title"></h5>
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
                    <h5 class="section-semi-title">Ответственный</h5>
                    <multiselect
                    v-model="rewriteTask.responsible"
                    :options="responsibleList"
                    :hide-selected="true"
                    :selectLabel="''"
                    :taggable="true"
                    placeholder="Ответственный"
                    @tag="addResponsibleTag"
                    track-by="name"
                    label="name"
                    />
                </div>
                <div class="col-md-12 mt-4">
                    <h5 class="section-semi-title">Ответственный исполнитель</h5>
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
                    <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.detectionDate" placeholder="Select Date"/>
                </div>
                <div class="col-md-6 mt-4">
                    <h5 class="section-semi-title">Контрольный срок</h5>
                    <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.targetDate" placeholder="Select Date"/>
                </div>
                <div class="col-md-6 mt-4">
                    <h5 class="section-semi-title">Дата устранения</h5>
                    <div class="row">
                    <div class="col-md-8 col-12">
                        <datepicker input-class="form-control" format="dd.MM.yyyy" v-model="rewriteTask.correctionDate" placeholder="Select Date"/>
                    </div>
                    <div class="col-md-4 col-12">
                        <button class="btn btn-default" @click="rewriteTask.correctionDate = null">Очистить</button>
                    </div>
                    </div>
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
                    <vue-dropzone id="drop1" :useCustomSlot="true" :options="config" @vdropzone-complete="afterComplete" @vdropzone-removed-file="removedImage" ref="myVueDropzone">
                    <div class="dropzone-custom-content">
                        <h3 class="dropzone-custom-title mt-2">Перетащите свои фотографии сюда!</h3>
                        <div class="subtitle">... или нажмит на это поле</div>
                    </div>
                    </vue-dropzone>
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
      console.log('Save')
    },
    async getTask (id) {
      let userResponse = await window.axios.post('/api/admin/profile')
      let identifiedResponse = await window.axios.post('/api/admin/users')
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