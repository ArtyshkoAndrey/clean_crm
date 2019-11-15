<template>
  <div class="card-body">
    <div class="row">
      <div class="col-md-6 mt-1">
        <h5 class="section-semi-title">Название нарушения</h5>
        <input type="text" v-model="rewriteTask.name" class="form-control" placeholder="Название проблемы" required>
      </div>
      <div class="col-md-12 mt-4">
        <h5 class="section-semi-title">Описание нарушения</h5>
        <textarea class="form-control" v-model="rewriteTask.description" placeholder="Описание" rows="3" />
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
</style>

<script>
  import Datepicker from 'vuejs-datepicker'
  import VueSuggestions from 'vue-suggestions'
  import Multiselect from 'vue-multiselect'
  import vue2Dropzone from 'vue2-dropzone'
  export default {
    props: {
    rewriteTask: {
      type: Object,
      require: true,
      default: Object
    },
    rewriteTask: {
      type: Object,
      require: true,
      default: {}
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
    }
  },
  data () {
    return {
      config: {
        url: "http://clean-crm/api/taskfile",
        thumbnailWidth: null,
        addRemoveLinks: true,
        renameFile: function (file) {
          let newName = new Date().getTime() + '_' + file.name;
          return newName;
        },
      },
      dataNumber: [],
      dataStreet: [],
      saved: false
    }
  },
  components: {
    vueDropzone: vue2Dropzone,
    Datepicker,
    VueSuggestions,
    Multiselect
  },
  mounted () {
    setTimeout(() => {
      console.log(this.rewriteTask.images)
      this.rewriteTask.images.forEach(image => {
        typeof image.path === 'string' ? image.path = JSON.parse(image.path) : null
        this.$refs.myVueDropzone.manuallyAddFile({ type: image.path.type, size: image.path.size, name: image.path.name}, image.path.file);
      })
    }, 1000);
  },
  methods: {
    async removedImage (file, error, xhr) {
      if(!this.saved) {
        let name
        if (file.constructor.name !== 'File') {
          name = file.name
        } else {
          name = file.upload.filename
        }
        window.axios.delete('http://clean-crm/api/taskfile/'+name)
        .then(response => {
          let removeIndex = this.rewriteTask.images.map(function(item) { return item.path.name; }).indexOf(file.name);
          ~removeIndex && this.rewriteTask.images.splice(removeIndex, 1);
          response.data.success ? window.toastr['success']('Выполнено', response.data.success) : window.toastr['error']('Ошибка', response.data.error)
        })
        .catch(error => {
          console.log(error)
          window.toastr['error']('Ошибка', 'Не выполнено')
        });
      }
    },
    async save () {
      this.$emit('save');
      this.saved = true
      if (this.type === 'update') {
        console.log(this.task)
        console.log(this.rewriteTask)
        window.axios.put('/api/admin/task', this.rewriteTask)
        .then(response => {
          console.log(response)
          response.data === 'Success' ? window.toastr['success']('Выполнено', 'Сохранено') : window.toastr['error']('Ошибка', 'Не выполнено')
        })
        .catch(error => {
          console.log(error)
          window.toastr['error']('Ошибка', 'Не выполнено')
        });
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
    afterComplete(file) {
      console.log(file);
      try {
        let image = JSON.parse(file.xhr.response).image
        image.path.name = file.upload.filename
        this.rewriteTask.images.push(image)
      } catch (e) {
        console.warn(e)
      }
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