<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Все пользователи</h3>
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
							<table-column show="avatar" label=""/>
              <table-column show="name" label="ФИО"/>
              <table-column show="email" label="Email"/>
							<table-column show="department" label="Отдел"/>
							<table-column show="role" label="Роль"/>
              <table-column show="birthday" label="Дата рождения"/>
              <table-column
                :sortable="false"
                :filterable="false"
                label=""
              >
                <template slot-scope="row">
                  <div class="table__actions">
                    <button class="btn btn-default btn-sm mr-2" @click="$router.push({name: 'userView', params: { id: row.id}})">
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

<style>
.fade-enter-active,
.fade-leave-active {
    transition: opacity .5s
}

.fade-enter,
.fade-leave-to {
    opacity: 0
}
</style>