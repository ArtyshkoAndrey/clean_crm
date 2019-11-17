<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Все отделы</h3>
          </div>
          <div class="card-body" style="overflow: auto">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th scope="col">№</th>
                  <th scope="col">Назавние</th>
                  <th scope="col">Руководитель</th>
                  <th scope="col">Сотрудники</th>
                  <th scope="col">Действия</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="task in tasks" :key="task.id">
                  <td scope="row">{{ task.id }}</td>
                  <td>{{ task.name }}</td>
                  <td>{{ task.street }}, {{ task.number_home }}</td>
                  <td>{{ task.identified[0].name }}</td>
                  <td>
                    <div class="btn-group" role="group">
                      <v-dropdown :show-arrow="false" theme-light>
                        <button
                          id="btnGroupDrop1"
                          slot="activator"
                          type="button"
                          class="btn btn-outline-default dropdown-toggle"
                          data-toggle="dropdown"
                          aria-haspopup="true"
                          aria-expanded="false"
                        >
                        </button>
                        <v-dropdown-item>
                          <button class="dropdown-item" @click='$router.push({ name: "taskView", params: { id: task.id }})'>
                            Просмотреть
                          </button>
                        </v-dropdown-item>
                        <v-dropdown-item>
                          <button class="dropdown-item" @click='$router.push({ name: "taskCreate", params: { id: task.id }})'>
                            Редактировать
                          </button>
                        </v-dropdown-item>
                        <v-dropdown-item>
                          <button class="dropdown-item">
                            Удалить
                          </button>
                        </v-dropdown-item>
                      </v-dropdown>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
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