export default class Task {
  constructor (task) {
    for (let key in task) {
      let CamelCaseKey = key.replace(/[-_]([a-z])/g,
        (m) => {
          return m[1].toUpperCase()
        }
      )
      this[CamelCaseKey] = task[key]
      if (CamelCaseKey === 'street') {
        this[CamelCaseKey] = {}
        this[CamelCaseKey]['value'] = task[key]
      }
      if (CamelCaseKey.includes('Date')) {
        if (this[CamelCaseKey]) {
          this[CamelCaseKey] = new Date(this[CamelCaseKey].slice(6, 10), parseInt(this[CamelCaseKey].slice(3, 5)) - 1, this[CamelCaseKey].slice(0, 2))
        }
        Object.defineProperty(this, '_' + CamelCaseKey + 'String', {
          get: function () {
            if (this[CamelCaseKey]) {
              return this[CamelCaseKey].toLocaleString()
            } else {
              return ''
            }
          }
        })
      }
    }
  }
}
