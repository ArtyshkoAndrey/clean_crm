<template>
  <div id="dashboardPage" class="main-content">
    <div class="row">
      <div class="col-md-12 col-lg-6 col-xl-3">
        <!-- TODO: роутинг в задачи которые выполняются -->
        <a class="dashbox" href="#">
          <i class="icon-fa icon-fa-clock-o text-warning"/>
          <span class="title">
            {{work}}
          </span>
          <span class="desc">
            В работе
          </span>
        </a>
      </div>
      <div class="col-md-12 col-lg-6 col-xl-3">
        <!-- TODO: роутинг в задачи которые просроченные -->
        <a class="dashbox" href="#">
          <i class="icon-fa icon-fa-clock-o text-danger"/>
          <span class="title">
            {{overdue}}
          </span>
          <span class="desc">
            Просроченные
          </span>
        </a>
      </div>
      <div class="col-md-12 col-lg-6 col-xl-3">
        <!-- TODO: роутинг в задачи которые просроченные -->
        <a class="dashbox" href="#">
          <i class="icon-fa icon-fa-check-circle-o text-success"/>
          <span class="title">
            {{complete}}
          </span>
          <span class="desc">
            Устраненные
          </span>
        </a>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h6><i class="icon-fa icon-fa-clock-o text-danger"/>Просроченные задачи</h6>
          </div>
          <div class="card-body">
            <table class="table">
              <thead>
                <tr>
                  <th>Адрес</th>
                  <th>Описание проблемы</th>
                  <th class="d-none d-md-table-cell">Контрольный срок</th>
                </tr>
              </thead>
              <tbody v-for='task in tasks' :key='task.id' class="custom-table">
                <tr @click="taskDetails(task.id)">
                  <td>{{ task.street + ', ' + task.number_home }}</td>
                  <td>{{ task.name }}</td>
                  <td class="d-none d-md-table-cell">{{ task.target_date }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="section-semi-title">
              График выполненых задач
            </h5>
            <bar-chart
              :labelForDataset="'Выполнено'"
              :labels="['Январь', 'Февраль', 'Март', 'Апрель',
            'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь']"
              :values="[randomInt(), randomInt(), randomInt(), randomInt(), randomInt(),
                randomInt(), randomInt(), randomInt(), randomInt(), randomInt()]"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script type="text/babel">
import BarChart from '../../../components/chartjs/BarChart.vue'
export default {
  data () {
    return {
      'header': 'header',
      count: 2,
      tasks: [],
      work: 0,
      complete: 0,
      overdue: 0,
    }
  },
  components: {
    BarChart
  },
  mounted() {
    this.fetch()
  },
  methods: {
    async fetch() {
      await window.axios.get('/api/admin/dashboard')
        .then(response => {
          if (response.data.status === 'success') {
            this.work = response.data.work
            this.overdue = response.data.overdue
            this.tasks = response.data.taskOverdue
            this.complete = response.data.complete
          } else {
            window.toastr['error']('Ошибка сохранения', 'Загрузка данных')
          }
        })
        .catch(error => {
          console.log(error)
          window.toastr['error']('Ошибка сохранения', 'Загрузка данных')
        })
    },
    randomInt () {
      return Math.floor(Math.random() * (40 - 0))
    },
    taskDetails (id) {
      console.log(id)
    }
  }
}
</script>
