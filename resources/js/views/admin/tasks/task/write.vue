<template>
  <div class="card-body">
    <div class="row">
      <div class="col-md-6 mt-1">
        <h5 class="section-semi-title">Название нарушения</h5>
        <input
          v-validate
          v-model="rewriteTask.name"
          :class="['form-control', {'is-invalid': errors.has('rewriteTask.name') }]"
          name="rewriteTask.name"
          data-vv-rules="required"
          placeholder="Название нарушения">
        <div v-show="errors.has('rewriteTask.name')" class="invalid-feedback">
          Это обязательное поле для заполнения
        </div>
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Описание нарушения</h5>
        <textarea
          v-validate
          v-model="rewriteTask.description"
          :class="['form-control', {'is-invalid': errors.has('rewriteTask.description') }]"
          data-vv-rules="required"
          name="rewriteTask.description"
          placeholder="Описание"
          rows="3"/>
        <div v-show="errors.has('rewriteTask.description')" class="invalid-feedback">
          Это обязательное поле для заполнения
        </div>
      </div>
      <div class="col-md-6 mt-4">
        <h5 class="section-semi-title">Улица</h5>
        <multiselect
          v-validate
          id="ajax"
          v-model="rewriteTask.street"
          :options="dataStreet"
          :searchable="true"
          :multiple="false"
          :select-label="''"
          :class="{'is-invalid-select': errors.has('rewriteTask.street') }"
          placeholder="Название улицы"
          data-vv-rules="required"
          name="rewriteTask.street"
          label="value"
          @search-change="getStreet"/>
        <div v-show="errors.has('rewriteTask.street')" class="invalid-feedback">
          Это обязательное поле для заполнения
        </div>
      </div>
      <div class="col-md-6 mt-4">
        <h5 class="section-semi-title">Номер дома</h5>
        <multiselect
          id="ajax"
          v-model="rewriteTask.numberHome"
          :options="dataNumber"
          :searchable="true"
          :multiple="false"
          :select-label="''"
          placeholder="Номер дома"
          @search-change="getNumberHome"
        />
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Кем выявлено</h5>
        <multiselect
          v-model="rewriteTask.identified"
          :options="identifiedList"
          :multiple="true"
          :hide-selected="true"
          :select-label="''"
          :searchable="true"
          placeholder="Кем выявлено"
          label="name"
          track-by="id"
        />
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Ответственный</h5>
        <multiselect
          v-model="rewriteTask.responsible"
          :options="responsibleList"
          :hide-selected="true"
          :select-label="''"
          :taggable="true"
          placeholder="Ответственный"
          track-by="name"
          label="name"
          @tag="addResponsibleTag"
        />
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Ответственный исполнитель</h5>
        <input
          v-model="rewriteTask.responsibleExecutor"
          type="text"
          class="form-control"
          placeholder="Ответственный исполнитель"
        >
      </div>
      <div class="col-md-6 mt-4">
        <h5 class="section-semi-title">Дата выявления</h5>
        <datepicker
          v-model="rewriteTask.detectionDate"
          input-class="form-control"
          format="dd.MM.yyyy"
          placeholder="Select Date"/>
      </div>
      <div class="col-md-6 mt-4">
        <h5 class="section-semi-title">Контрольный срок</h5>
        <datepicker
          v-model="rewriteTask.targetDate"
          input-class="form-control"
          format="dd.MM.yyyy"
          placeholder="Select Date"/>
      </div>
      <div class="col-md-6 mt-4">
        <h5 class="section-semi-title">Дата устранения</h5>
        <div class="row">
          <div class="col-md-8 col-12">
            <datepicker v-model="rewriteTask.correctionDate" input-class="form-control" format="dd.MM.yyyy" placeholder="Select Date"/>
          </div>
          <div class="col-md-4 col-12">
            <button class="btn btn-default" @click="rewriteTask.correctionDate = null">Очистить</button>
          </div>
        </div>
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Проведенная работа</h5>
        <textarea
          v-model="rewriteTask.conductedWork"
          class="form-control"
          rows="3"
          placeholder="Описание проведённой работы"
        />
      </div>
      <div class="col-12 mt-4">
        <h5 class="section-semi-title">Медиа файлы</h5>
        <vue-dropzone id="drop1" ref="myVueDropzone" :use-custom-slot="true" :options="config" @vdropzone-success="afterComplete" @vdropzone-removed-file="removedImage">
          <div class="dropzone-custom-content">
            <h3 class="dropzone-custom-title mt-2">Перетащите свои фотографии сюда!</h3>
            <div class="subtitle">... или нажмит на это поле</div>
          </div>
        </vue-dropzone>
      </div>
      <div class="col-12 mt-4 justify-content-center align-content-center d-flex">
        <button :disabled="!validateCheck" class="btn btn-primary mr-1" @click="save">Сохранить</button>
        <button class="btn btn-default ml-1" @click="$router.push({name: 'tasks'})">Отменить</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.dropzone-custom-content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}

.dropzone-custom-title {
  margin-top: 0;
  color: #00b782;
}

.subtitle {
  color: #314b5f;
}

.form-control[readonly] {
  background: #fff;
}

.dropzone-custom-title {
  color: #000;
}

.multiselect__tags.is-invalid {
  border-color: #f35a3d;
  padding-right: calc(1.5em + 0.75rem);
}
</style>

<script>
import Datepicker from 'vuejs-datepicker'
import VueSuggestions from 'vue-suggestions'
import Multiselect from 'vue-multiselect'
import vue2Dropzone from 'vue2-dropzone'
import Ls from '../../../../services/ls'

export default {
  components: {
    vueDropzone: vue2Dropzone,
    Datepicker,
    VueSuggestions,
    Multiselect
  },
  props: {
    rewriteTask: {
      type: Object,
      require: true,
      default: Object
    },
    task: {
      type: Object,
      require: true,
      default: Object
    },
    user: {
      type: Object,
      require: true,
      default: Object
    },
    allUsers: {
      type: Array,
      require: true,
      default: Array
    },
    responsibleList: {
      type: Array,
      require: true,
      default: Array
    },
    identifiedList: {
      type: Array,
      require: true,
      default: Array
    },
    mode: {
      type: String,
      require: true,
      default: 'create'
    }
  },
  data () {
    return {
      config: {
        url: '/api/admin/task/file',
        // thumbnailWidth: null,
        addRemoveLinks: true,
        headers: {Authorization: 'Bearer ' + Ls.get('auth.token')},
        renameFile: function (file) {
          return new Date().getTime() + '_' + file.name
        }
      },
      dataNumber: [],
      dataStreet: [],
      saved: false
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
    setTimeout(() => {
      console.log(this.rewriteTask.images)
      this.rewriteTask.images.forEach(image => {
        // eslint-disable-next-line no-unused-expressions
        typeof image.path === 'string' ? image.path = JSON.parse(image.path) : null
        console.log(image)
        this.$refs.myVueDropzone.manuallyAddFile({ type: image.path.type, size: image.path.size, name: image.path.name}, 'http://clean-crm' + image.path.file)
      })
    }, 1000)
  },
  methods: {
    async removedImage (file, error, xhr) {
      if (!this.saved) {
        let name
        if (file.constructor.name !== 'File') {
          name = file.name
        } else {
          name = file.upload.filename
        }
        window.axios.delete('http://clean-crm/api/task/file/' + name)
          .then(response => {
            let removeIndex = this.rewriteTask.images.map(function (item) { return item.path.name }).indexOf(file.name)
            ~removeIndex && this.rewriteTask.images.splice(removeIndex, 1)
            response.data.success ? window.toastr['success']('Выполнено', response.data.success) : window.toastr['error']('Ошибка', response.data.error)
          })
          .catch(error => {
            console.log(error)
            window.toastr['error']('Ошибка', 'Не выполнено')
          })
      }
    },
    async save () {
      this.$emit('save')
      this.saved = true
      if (this.mode === 'update') {
        console.log(this.task)
        console.log(this.rewriteTask)
        window.axios.put('/api/admin/task/' + this.rewriteTask.id, this.rewriteTask)
          .then(response => {
            console.log(response)
            response.data === 'Success' ? window.toastr['success']('Выполнено', 'Сохранено') : window.toastr['error']('Ошибка', 'Не выполнено')
          })
          .catch(error => {
            console.log(error)
            window.toastr['error']('Ошибка', 'Не выполнено')
          })
      }
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
    afterComplete (file, response) {
      console.log(file)
      console.log(response)
      try {
        let image = JSON.parse(file.xhr.response).image
        image.path.name = file.upload.filename
        this.rewriteTask.images.push(image)
      } catch (e) {
        console.warn(e)
      }
    },
    async getNumberHome (query) {
      console.log(this.rewriteTask.street + ' ' + query)
      window.axios.post('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address',
        {
          query: query,
          locations: [
            {
              city: 'Красноярск',
              street_fias_id: this.rewriteTask.street.data.street_fias_id
            }
          ],
          restrict_value: true
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token be33fe1fe0328828d9632c248dcad68166e62740',
            'X-Secret': '23c196abec29f8f3bafeb96f8be339c491a3bb77'
          }
        }
      ).then(res => {
        this.dataNumber = []
        res.data.suggestions.forEach(element => {
          this.dataNumber.push(element.value)
        })
        console.log(this.dataNumber)
      })
    },
    async getStreet (query) {
      window.axios.post('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address',
        {
          query: query,
          locations: [
            {
              city: 'Красноярск'
            }
          ],
          restrict_value: true
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token be33fe1fe0328828d9632c248dcad68166e62740',
            'X-Secret': '23c196abec29f8f3bafeb96f8be339c491a3bb77'
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
