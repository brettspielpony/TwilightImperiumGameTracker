class PlayerScoreDisplay extends HTMLElement {
  connectedCallback () {
    this.insertAdjacentHTML('afterbegin', `<div class="player-score-display js-display"></div>`)
    this._display = this.querySelector('.js-display')
    this._playerName = this.getAttribute('player-name')

    this.addEventListener('change', (event) => {
      const score = parseInt(event.target.value)
      this.updateDisplay(score)
    })

    // NOTE: For *some* reason one could not do just ['a', 'b'].forEach(…)
    let eventTypes = ['DOMContentLoaded', 'turbolinks:load']
    eventTypes.forEach(eventType => {
      document.addEventListener(eventType, (event) => {
        this.updateDisplay(this.getScore())
      })
    })
  }

  updateDisplay(score) {
    this._display.innerHTML = `<strong>${this._playerName}</strong>: ${score}`
  }

  getScore() {
    return this.querySelector('input').value
  }
}
customElements.define('player-score-display', PlayerScoreDisplay)

export default PlayerScoreDisplay
