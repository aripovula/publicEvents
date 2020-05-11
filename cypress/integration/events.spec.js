context('LPEvents index', () => {

  beforeEach(() => {
    cy.visit('http://localhost:5000/event')
    cy.fixture('events.json').as('events')
  })

  it('opens new event form when +new is clicked', function() {
    cy.get('#newAncr').click()
    cy.get('h2').should('contain', 'Add new event')
  })

  // TODO: find way of clicking on detached anchor link
  xit('adds new event', function () {
    cy.visit('http://localhost:5000/event/new')
    cy.get('input#lp_event_title')
      .type(this.events[0].title)
    cy.get('input#lp_event_type')
      .type(this.events[0].type)
    cy.contains('Save')
      .click()
    cy.contains(this.events[0].title)
    cy.get('h1').should('contain', 'Event Details')
    cy.visit('http://localhost:5000/event')
    cy.contains(this.events[0].title).click()
    cy.get('h1').should('contain', 'Event Details')
  })

  it('changes page # when next is clicked', function () {
    cy.get('h3').should('contain', 'Upcoming events!')
    cy.get('h4').should('contain', 'page 1')
    cy.contains('next').click()
    cy.contains('next').click()
    cy.get('h4').should('contain', 'page 3')
  })

  // TODO: find way of clicking on detached anchor link
  xit('deletes event only if confirmed', function () {
    cy.visit('http://localhost:5000/event/new')
    cy.get('input#lp_event_title').type(this.events[1].title)
    cy.get('input#lp_event_type').type(this.events[1].type)
    cy.contains('Save').click()
    cy.visit('http://localhost:5000/event')
    cy.contains(this.events[1].title)
    cy.get(`a[phx-test-id="delete_lp_event_${this.events[1].title}"]`).click()
    cy.contains(this.events[1].title).should('not.exist')
  })

})
