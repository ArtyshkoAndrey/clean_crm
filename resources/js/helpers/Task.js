export default class Task {
  constructor (task) {
    this.id = task.id
    this.street = {}
    this.street.value = task.street
    this.dateOfDetection = this.reformatDateAPI(task.date_of_detection)
    this.numberHome = task.number_home
    this.responsible = task.responsible
    this.identified = task.identified
    this.name = task.name
    this.description = task.description
    this.targetDate = this.reformatDateAPI(task.target_date)
    this.correctionDate = this.reformatDateAPI(task.correction_date)
    this.responsibleExecutor = task.responsible_executor
    this.conductedWork = task.conducted_work
    this.images = task.images
    this._targetDate = null
    this._correctionDate = null
    this._dateOfDetection = null
  }

  reformatDateAPI (date = null) {
    try {
      if (date) {
        return new Date(date.slice(6, 10), parseInt(date.slice(3, 5)) - 1, date.slice(0, 2))
      } else {
        return ''
      }
    } catch (e) {
      console.error(e)
      return Date(Date.now())
    }
  }

  reformatDateToAPI () {
    this._targetDate = this.targetDate.toLocaleDateString()
    if (this.correctionDate) {
      this._correctionDate = this.correctionDate.toLocaleDateString()
    }
    this._dateOfDetection = this.dateOfDetection.toLocaleDateString()
  }
}
