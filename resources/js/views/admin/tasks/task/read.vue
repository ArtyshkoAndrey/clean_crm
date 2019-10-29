<template>
  <div class="card-body">
    <div class="row">
      {{ task.name }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    task: {
      type: Object,
      require: true,
      default: Object
    }
  }
  // data () {
  //   return {
    
  //   }
  // }
}
</script>