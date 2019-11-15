<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Фильтры</h3>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 d-flex flex-column justify-content-between">
                <multiselect
                  v-model="currentChoose"
                  :options="filterColumns"
                  :hide-selected="true"
                  :selectLabel="''"
                  track-by="name"
                  label="name"
                  placeholder="Выберете параметр"
                  class="mt-2"
                />
                <a href="#" class="filter-add-button mt-2">Отфильтровать</a>
              </div>
              <div class="col-md-6">
                <div v-for="column in choosedColumns"
                  v-bind:key="column.name">
                  <input v-if="column.type == 'text'"
                    v-model="column.value"
                    v-bind:key="column.name"
                    :placeholder="column.name"
                    type="text"
                    class="form-control mt-2">
                  <multiselect v-else-if="column.type == 'select'"
                    v-model="column.value"
                    :options="column.options"
                    :hide-selected="true"
                    :selectLabel="''"
                    placeholder="Выберете параметр"
                    class="mt-2"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-header">
            <h3>Все правонарушения</h3>
          </div>
          <div class="card-body">
            <table-component
              :data="getTasks"
              table-class="table"
              sort-by="detection_date"
              sort-order="desc"
              filter-placeholder="Поиск"
              filterNoResults="Нет данных"
              ref="tableTasks"
            >
              <table-column show="street" label="Улица"/>
              <table-column show="number_home" label="Номер дома"/>
              <table-column show="detection_date" label="ДАТА ВЫЯВЛЕНИЯ"/>
              <table-column show="description" label="Описание"/>
              <table-column show="target_date" label="КОНТРОЛЬНЫЙ СРОК"/>
              <table-column
                :sortable="false"
                :filterable="false"
                label=""
              >
                <template slot-scope="row">
                  <div class="table__actions">
                    <button class="btn btn-default btn-sm mr-2" @click="$router.push({name: 'taskView', params: { id: row.id}})">
                      Изменть
                    </button>
                    <button class="btn btn-default btn-sm" @click="dropTask(row.id)">
                      Удалить
                    </button>
                  </div>
                </template>
              </table-column>
            </table-component>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script type="text/babel">
import { TableComponent, TableColumn } from 'vue-table-component'
import Multiselect from 'vue-multiselect'

export default {
  data () {
    return {
      'header': 'header',
      count: 0,
      tasks: [],
      filterColumns: [{
        name: "Улица",
        value: "",
        type: "text"
      },
      {
        name: "Дом",
        value: "",
        type: "text"
      },
      {
        name: "Статус",
        value: "",
        type: "select",
        options: ["В работе", "Просроченные", "Выполненные"]
      }],
      choosedColumns: [],
      currentChoose: "",
      loading: true
    }
  },
  components: {
    TableComponent,
    TableColumn,
    Multiselect
  },
  mounted () {
    // this.getTasks()
  },
  watch: {
    currentChoose: function (val) {
      this.filterColumns.splice(this.filterColumns.indexOf(val), 1)
      this.choosedColumns.push(val)
      console.log(this.filterColumns, this.choosedColumns)
    }
  },
  methods: {
    taskDetails (id) {
      console.log(id)
    },
    checkColor(row) {
      let endDay = new Date()
      endDay.setDate(row.target_date.slice(0, 2))
      endDay.setMonth(parseInt(row.target_date.slice(3, 5)) - 1)
      endDay.setFullYear(row.target_date.slice(6, 10))
      endDay = Date.parse(endDay)
      let nowDay = Date.now()
      if (nowDay >= endDay) {

        return 'table-danger'
      }
    },
    async getTasks ({ page, filter, sort }) {
      console.log( page, filter)
      sort ? console.log(sort) : null
      let response = await window.axios.get('/api/admin/task/get', {
        params: {
          page: page,
          filter: filter,
          sortName: sort.fieldName,
          sortType: sort.order
        }
      })
      console.log(response)
      return {
        data: response.data.data,
        pagination: {
          totalPages: response.data.last_page,
          currentPage: page,
          count: response.data.count
        }
      }
    },
    async dropTask (id) {
      let response = await window.axios.post('/api/admin/task/' + id, { _method: 'DELETE' })
      console.log(response)
      if (response.status == 200 && response.data == 'Success') {
        window.toastr['success']('Задача удалена', 'Выполнено')
        this.$refs.tableTasks.refresh()
      } else {
        window.toastr['error']('Ошибка', 'Не выполнено')
        this.$refs.tableTasks.refresh()
      }
    }
  }
}
</script>

<style scoped>
.filter-add-button {
  display: block;
  border: 1px solid gray;
  padding: .5rem 1rem;
  text-align: center;
  transition-duration: .5s;
}

.filter-add-button:hover {
  background: lightgray;
  transition-duration: .5s;
  border-color: lightgray;
}
</style>