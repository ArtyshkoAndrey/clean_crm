<template>
  <div class="card-body">
    <div class="row">
      <div class="col-12 mt-4">
        <h6>Навзавние проблемы: <strong>{{ task.name }}</strong></h6>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Описание проблемы:</h6>
        <p class="mt-0 pt-0 lead">{{ task.description }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Улица, дом</h6>
        <p class="mt-0 pt-0 lead">{{ task.street.value }}, {{ task.numberHome }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Кем выявлено</h6>
        <p class="mt-0 pt-0 lead"><span v-for="user in task.identified" :key="user.id">{{ user.name }}, </span></p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Ответсвенный</h6>
        <p class="mt-0 pt-0 lead">{{ task.responsible.name }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Ответсвенный исполнитель</h6>
        <p class="mt-0 pt-0 lead">{{ task.responsibleExecutor }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Дата выявления</h6>
        <p class="mt-0 pt-0 lead">{{ task.detectionDate.toLocaleDateString() }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Дата устранения</h6>
        <p v-if="task.correctionDate !== null" class="mt-0 pt-0 lead">{{ task.correctionDate.toLocaleDateString() }}</p>
        <p v-else class="mt-0 pt-0 lead"><strong>Не указана</strong></p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Констролный срок</h6>
        <p class="mt-0 pt-0 lead">{{ task.targetDate.toLocaleDateString() }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Проведенная работа</h6>
        <p class="mt-0 pt-0 lead">{{ task.conductedWork }}</p>
      </div>
      <div class="col-12 mt-2">
        <h6 class="pb-0 mb-0">Медиафайлы</h6>
        <div class="row">
          <div class="col-md-8 offset-md-2">
            <carousel :controls="true" :per-page-custom="[[480, 1]]">
              <slide v-for="img in task.images" :key="img.id">
                <img :src="img.path.file" class="img-fluid" alt="image from carousel" style="max-height: 500px">
              </slide>
            </carousel>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { Carousel, Slide } from 'vue-carousel'
export default {
  components: {
    Carousel,
    Slide
  },
  props: {
    task: {
      type: Object,
      require: true,
      default: Object
    }
  }
}
</script>
