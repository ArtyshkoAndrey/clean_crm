<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h6>Все задачи</h6>
          </div>
          <div class="card-body">
            <!-- <table class="table table-hover">
              <thead>
                <tr>
                  <th></th>
                  <th>Адрес</th>
                  <th>Дата выявления</th>
                  <th class="d-none d-md-table-cell">Описание проблемы</th>
                  <th class="d-none d-md-table-cell">Контрольный срок</th>
                </tr>
              </thead>
              <transition name="fade" mode="out-in">
              <tbody v-if="count > 0" key=1>
                <tr v-for='task in tasks' :key='task.id'>
                  <td>
                    <div style="height: 50px; width: 50px" class="text-center">
                        <i class="icon-fa icon-fa-ellipsis-h" style="height: 25px" />
                    </div>
                  </td>
                  <td>{{ task.street + ' ' + task.number_home }}</td>
                  <td>{{ task.date_of_detection }}</td>
                  <td class="d-none d-md-table-cell">{{ task.description }}</td>
                  <td class="d-none d-md-table-cell">{{ task.target_date }}</td>
                </tr>
              </tbody>
              <tbody v-else-if='loading' key=2>
                <tr>
                  <td class="font-weight-bold text-center" colspan="5">
                    <div class="spinner-border text-primary" role="status">
                      <span class="sr-only">Loading...</span>
                    </div>
                  </td>
                </tr>
              </tbody>
              <tbody v-else key=3>
                <tr>
                  <td class="font-weight-bold text-center" colspan="5">Нет просроченных задач</td>
                </tr>
              </tbody>
              </transition>
            </table> -->
            <!-- <hr> -->
            <table-component
              :data="getTasks"
              table-class="table"
              sort-by="date_of_detection"
              sort-order="desc"
              filter-placeholder="Поиск"
              filterNoResults="Нет данных"
              ref="tableTasks"
            >
              <table-column show="street" label="Улица"/>
              <table-column show="number_home" label="Номер дома"/>
              <table-column show="date_of_detection" label="ДАТА ВЫЯВЛЕНИЯ"/>
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
export default {
  data () {
    return {
      'header': 'header',
      count: 0,
      tasks: [],
      loading: true
    }
  },
  components: {
    TableComponent,
    TableColumn
  },
  mounted () {
    // this.getTasks()
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