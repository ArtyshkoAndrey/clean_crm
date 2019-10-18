<template>
  <div id="dashboardPage" class="main-content">
    <div class="row">
      <div class="col-md-12 col-lg-6 col-xl-3">
        <!-- TODO: роутинг в задачи которые выполняются -->
        <a class="dashbox" href="#">
          <i class="icon-fa icon-fa-check-circle-o text-primary"/>
          <span class="title">
            35
          </span>
          <span class="desc">
            Выполнемые
          </span>
        </a>
      </div>
      <div class="col-md-12 col-lg-6 col-xl-3">
        <!-- TODO: роутинг в задачи которые просроченные -->
        <a class="dashbox" href="#">
          <i class="icon-fa icon-fa-clock-o text-danger"/>
          <span class="title">
            2
          </span>
          <span class="desc">
            Просроченные
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
              <thead v-if="count > 0">
                <tr>
                  <th>Адрес</th>
                  <th>Описание проблемы</th>
                  <th class="d-none d-md-table-cell">Контрольный срок</th>
                </tr>
              </thead>
              <thead v-else>
                <tr>
                  <th>Адрес</th>
                  <th>Описание проблемы</th>
                  <th class="d-none d-md-table-cell">Контрольный срок</th>
                </tr>
              </thead>
              <tbody v-if="count > 0" class="custom-table">
                <tr @click="taskDetails(1)">
                  <td>ул. Горького 24</td>
                  <td>На дереве целлофан</td>
                  <td class="d-none d-md-table-cell">23.04.2019</td>
                </tr>
                <tr @click="taskDetails(2)">
                  <td>ул. Горького 25</td>
                  <td>Граффити</td>
                  <td class="d-none d-md-table-cell">13.05.2019</td>
                </tr>
              </tbody>
              <tbody v-else class="custom-table">
                <tr >
                  <td class="font-weight-bold text-center" colspan="3">Нет просроченных задач</td>
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
      count: 2
    }
  },
  components: {
    BarChart
  },
  methods: {
    randomInt () {
      return Math.floor(Math.random() * (40 - 0))
    },
    taskDetails (id) {
      console.log(id)
    }
  }
}
</script>
