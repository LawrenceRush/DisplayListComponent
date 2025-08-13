public with sharing class ContactListBuilder implements BuilderInterface{
    private Account acct;

    public ContactListBuilder setSObject(SObject sobj) {
        this.acct = (Account)sobj;
        return this;
    }

    public PersonList build() {
        PersonList personList = new PersonList();

        if (acct != null && acct.Contacts != null) {
            for (Contact c : acct.Contacts) {
                PersonList.Person person = new PersonList.Person();
                person.firstName = c.FirstName;
                person.lastName = c.LastName;
                person.phoneNumber = c.Phone;
                personList.people.add(person);
            }
        }

        return personList;
    }
}