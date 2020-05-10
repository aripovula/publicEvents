context('LPEvents', () => {

  beforeEach(() => {
    cy.visit('http://localhost:5000/event/new')
    cy.fixture('events.json').as('events')
  })

  it('opens new event form and adds new event', function() {
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.url()
      .should('include', '/event/new')
    cy.get('input#lp_event_title')
      .type(this.events[0].title)
    cy.get('textarea#lp_event_description')
      .type(this.events[0].description)
    cy.get('input#lp_event_type')
      .type(this.events[0].type)
    cy.contains('Save')
      .click()
    cy.get('h1')
      .should('contain', 'Event Details')
    cy.get('li')
      .should('contain', this.events[0].title)
  })

  it('shows validation error note if event title is not typed', function () {
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.url()
      .should('include', '/event/new')
    cy.get('textarea#lp_event_description')
      .type(this.events[0].description)
    cy.get('input#lp_event_type')
      .type(this.events[0].type)
    cy.contains('Save')
      .click()
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.get('span')
      .should('contain', "can't be blank")
  })

  it('shows validation error note if event type is not selected', function () {
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.url()
      .should('include', '/event/new')
    cy.get('input#lp_event_title')
      .type(this.events[0].title)
    cy.get('textarea#lp_event_description')
      .type(this.events[0].description)
    cy.contains('Save')
      .click()
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.get('span')
      .should('contain', "can't be blank")
  })

  it('shows validation errors when invalid data is input', function () {
    cy.get('h2')
      .should('contain', 'Add new event')
    cy.url()
      .should('include', '/event/new')
    cy.get('input#lp_event_title')
      .type("a")
    cy.get('span')
      .should('contain', "should be at least 3 character(s)")

    cy.get('input#lp_event_maxParticipants')
      .type("0")
    cy.get('span')
      .should('contain', "must be greater than 0")
  })

  it('opens events table when Back button clicked', function () {
    cy.contains('Back').click()
    cy.get('h3').should('contain', 'Upcoming events!')
  })


})
