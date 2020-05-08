context('LPEvents', () => {

  
  beforeEach(() => {
    cy.visit('http://localhost:5000/event')
    cy.fixture('events.json').as('events')
  })

  it('changes page # when next is clicked', function() {
    cy.log(`There are ${this.events.length} administrators.`)
    cy.get('h3').should('contain', 'Upcoming events!')
    cy.get('h4').should('contain', 'page 1')
    cy.contains('next').click()
    cy.contains('next').click()
    cy.get('h4').should('contain', 'page 3')
  })

  // pending - to be completed upon new event adding feature completion
  xit('deletes event only if confirmed', function () {
    cy.log(`There are ${this.events.length} administrators.`)
    cy.get('h3').should('contain', 'Upcoming events!')
    cy.contains('Delete').click()
    // cy.wait(2000)
    // cy.contains('next').click()
  })

})
