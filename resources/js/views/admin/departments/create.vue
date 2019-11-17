<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <transition name="fade" mode="out-in">
          <div key=1 class="card" v-if='!loading'>
            <div class="card-header">
              <div class="col-12 d-flex align-items-center justify-content-between">
                <h3 class="d-flex h-100">Создание нового отдела</h3>
              </div>
            </div>
            <div class="card-body">
							<div class="row">
                <div class="col-md-6 mt-1">
									<h5 class="section-semi-title">Название отдела</h5>
									<input type="text"  class="form-control" placeholder="Название" required>
                </div>
                <div class="col-md-12 mt-3">
                  <h5 class="section-semi-title">Руководит ель</h5>
                  <multiselect
                    :options="[]"
                    :hide-selected="true"
                    :selectLabel="''"
                    :taggable="true"
                    placeholder="Руководитель"
                    track-by="name"
                    label="name"
                  />
                </div>
                <div class="col-md-12 mt-3">
									<h5 class="section-semi-title">Сотрудники</h5>
									<multiselect
										:multiple="true"
										:options="[]"
										placeholder="Сотрудники"
										:hide-selected="true"
										label="name"
										:selectLabel="''"
										:searchable="true"
										track-by="id"
									/>
                </div>
                <div class="col-12 mt-4 justify-content-center align-content-center d-flex">
									<button class="btn btn-primary mr-1" >Сохранить</button>
									<button class="btn btn-default ml-1" @click="$router.push({name: 'departments'})">Отменить</button>
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
import Datepicker from 'vuejs-datepicker'
import Multiselect from 'vue-multiselect'

export default {
  data () {
    return {
      'header': 'header',
      rewriteTask: {},
      user: {},
      allUsers: [],
      loading: false,
      config: {
        url: "http://clean-crm/api/taskfile",
        thumbnailWidth: null,
      },
      responsibleList: [],
      identifiedList: []
    }
  },
  components: {
		Datepicker,
		Multiselect
  },
  created() {
       
  },
  computed: {
    validateCheck () {
      if (this.rewriteTask.name &&
          this.rewriteTask.description &&
          this.rewriteTask.street &&
          this.rewriteTask.numberHome &&
          this.rewriteTask.identified.length > 0 &&
          this.rewriteTask.responsible &&
          this.rewriteTask.detectionDate &&
          this.rewriteTask.targetDate) {
            return true;
          }
      return false;
    }
  },
  methods: {
   
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