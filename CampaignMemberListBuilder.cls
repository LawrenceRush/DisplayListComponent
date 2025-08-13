public with sharing class CampaignMemberListBuilder Implements BuilderInterface {
    private Campaign campaignRecord;

    public CampaignMemberListBuilder setSObject(SObject record) {
        this.campaignRecord = (Campaign)record;
        return this;
    }

    public PersonList build() {
        PersonList personList = new PersonList();

        if (campaignRecord != null && campaignRecord.CampaignMembers != null) {
            for (CampaignMember cm : campaignRecord.CampaignMembers) {
                if (cm != null) {
                    PersonList.Person person = new PersonList.Person();
                    person.firstName = cm.FirstName;
                    person.lastName = cm.LastName;
                    person.phoneNumber = cm.Phone;
                    personList.people.add(person);
                }
            }
        }

        return personList;
    }
}