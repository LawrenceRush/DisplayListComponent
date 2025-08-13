public with sharing class OpportunityTeamListBuilder implements BuilderInterface {
    private Opportunity opportunityRecord;

    public OpportunityTeamListBuilder setSObject(SObject record) {
        this.opportunityRecord = (Opportunity)record;
        return this;
    }

    public PersonList build() {
        PersonList personList = new PersonList();

        if (opportunityRecord != null && opportunityRecord.OpportunityTeamMembers != null) {
            for (OpportunityTeamMember otm : opportunityRecord.OpportunityTeamMembers) {
                if (otm.User != null) {
                    PersonList.Person person = new PersonList.Person();
                    person.firstName = otm.User.FirstName;
                    person.lastName = otm.User.LastName;
                    person.phoneNumber = otm.User.Phone;
                    personList.people.add(person);
                }
            }
        }

        return personList;
    }
}
