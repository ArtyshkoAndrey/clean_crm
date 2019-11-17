<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h3>Фильтры</h3>
          </div>
          <div class="card-body">
            <div class="row" v-if="loading">
              Загрузка
            </div>
            <div class="row" v-else>
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
                <button @click="getTasks" class="filter-add-button mt-2">Отфильтровать</button>
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
                    track-by="name"
                    label="name"
                    placeholder="Выберете параметр"
                    class="mt-2"
                  />
                  <datepicker v-else-if='column.type === "date"' input-class="form-control" format="dd.MM.yyyy" v-model="column.value"/>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-header">
            <h3>Все правонарушения</h3>
          </div>
          <div class="card-body" style="overflow: auto">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th scope="col">№</th>
                  <th scope="col">Назавние</th>
                  <th scope="col">Описание нарушения</th>
                  <th scope="col">Адрес</th>
                  <th scope="col">Кем выявлено</th>
                  <th scope="col">Ответсвенный</th>
                  <th scope="col">Дата выявления</th>
                  <th scope="col">Контольный срок</th>
                  <th scope="col">Дата устранения</th>
                  <th scope="col">Статус</th>
                  <th scope="col">Действия</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="task in tasks" :key="task.id">
                  <td scope="row">{{ task.id }}</td>
                  <td>{{ task.name }}</td>
                  <td>{{ task.description }}</td>
                  <td>{{ task.street }}, {{ task.number_home }}</td>
                  <td>{{ task.identified[0].name }}</td>
                  <td>{{ task.responsible.name }}
                  <td>{{ task.detection_date }}</td>
                  <td>{{ task.target_date }}</td>
                  <td>
                    <span v-if="task.correction_date !== null">{{task.correction_date}}</span>
                    <span v-else>Не указана</span>
                  </td>
                  <td>статус</td>
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
                            Редактировать
                          </button>
                        </v-dropdown-item>
                        <v-dropdown-item>
                          <button class="dropdown-item" @click='dropTask(task.id)'>
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

table tr td,
table tr th {
  text-align: center;
}

.dropdown-item {
  color: black;
}

</style>

<script type="text/babel">
import Multiselect from 'vue-multiselect'
import Datepicker from 'vuejs-datepicker'
export default {
  data () {
    return {
      'header': 'header',
      page: 1,
      tasks: [],
      filterColumns: [{
        name: "Улица",
        field: 'street',
        value: "",
        type: "text"
      },
      {
        name: "Дом",
        field: 'number_home',
        value: "",
        type: "text"
      },
      {
        name: "Название",
        field: 'name',
        value: "",
        type: "text"
      },
      {
        name: "Ответственный",
        field: 'responsible',
        value: "",
        type: "select",
        options: []
      },
      {
        name: "Ответственый исполнитель",
        field: 'responsible_executor',
        value: "",
        type: "text"
      },
      {
        name: "Дата выявления",
        field: 'detection_date',
        value: "",
        type: "date"
      },
      {
        name: "Контрольный срок",
        field: 'target_date',
        value: "",
        type: "date"
      },
      {
        name: "Дата устранения",
        field: 'correction_date',
        value: "",
        type: "date"
      },
      {
        name: "Кем выявлено",
        field: 'identified',
        value: "",
        type: "select",
        options: []
      },
      {
        name: "Статус",
        field: 'status',
        value: "",
        type: "select",
        options: [
          {name: "В работе", value: 'work'},
          {name: "Просроченные", value: 'overdue'},
          {name: "Выполненные", value: 'complete'}
        ]
      }],
      choosedColumns: [],
      currentChoose: "",
      loading: true
    }
  },
  components: {
    Multiselect,
    Datepicker
  },
  created () {
    this.responsiblesArray()
    this.usersArray()
    this.getTasks()
  },
  watch: {
    currentChoose: function (val) {
      this.filterColumns.splice(this.filterColumns.indexOf(val), 1)
      this.choosedColumns.push(val)
      console.log(this.filterColumns, this.choosedColumns)
    }
  },
  methods: {
    async usersArray () {
      await window.axios.post('/api/admin/usershelp').then(response => {
        let col = this.filterColumns.find(col => col.field === 'identified')
        console.log(col, response.data)
        col.options = response.data
      })
      .catch(e => {
        console.error(e)
      })
    },
    async responsiblesArray () {
      await window.axios.post('/api/admin/responsibles').then(response => {
        let col = this.filterColumns.find(col => col.field === 'responsible')
        console.log(col, response.data)
        col.options = response.data
      })
      .catch(e => {
        console.error(e)
      })
    },
    async getTasks () {
      let params = {}
      params.filter = []
      this.choosedColumns.forEach(column => {
        if (column.type === 'text') {
          column.value !== '' ? params.filter.push(column) : null
        } else if (column.type === 'date') {
          let copy = Object.assign({}, column)
          copy.value.setHours(20)
          copy.value = copy.value.toJSON().substr(0, 10)
          params.filter.push(copy)
        } else if (column.type === 'select') {
          console.log(column.value)
          let copy = Object.assign({}, column)
          if (column.field !== 'status') {
            copy.value = copy.value.id
            delete copy.options
          } else {
            copy.value = copy.value.value
            delete copy.options
          }
          params.filter.push(copy)
        }
      })
      params.page = this.page
      console.log(params)
      await window.axios.post('/api/admin/task/get', params)
      .then(response => {
        console.log(response)
        this.tasks = response.data
      })
      .catch(error => console.log(error))
      .finally(() => (this.loading = false));
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

