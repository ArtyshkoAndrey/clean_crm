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
            >
              <table-column show="street" label="Улица"/>
              <table-column show="number_home" label="Номер дома"/>
              <table-column show="date_of_detection" label="ДАТА ВЫЯВЛЕНИЯ"/>
              <table-column
                show="description"
                label="ДАТА ВЫЯВЛЕНИЯ"
              />
              <table-column
                show="target_date"
                label="КОНТРОЛЬНЫЙ СРОК"
              />
              <table-column
                :sortable="false"
                :filterable="false"
                label=""
              >
                <template slot-scope="row">
                  <div class="table__actions">
                    <a class="btn btn-default btn-sm" :href="row.id">
                      Изменть
                    </a>
                    <a class="btn btn-default btn-sm" :href="row.id">
                      Удалить
                    </a>
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
    async getTasks ({ page, filter, sort }) {
      console.log('/api/admin/tasks/get?page=' + page)
      let response = await window.axios.get('/api/admin/tasks/get?page=' + page)
      console.log(response.data)
      return {
        data: response.data.data,
        pagination: {
          totalPages: response.data.last_page,
          currentPage: page,
          count: response.data.count
        }
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