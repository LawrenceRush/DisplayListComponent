public Without Sharing class Finder {

    public List<List<SObject>> findList(Id recordId) {
        List<List<SObject>> results = new List<List<SObject>>();

        // Account + Contacts
        List<SObject> accounts = [
            SELECT Id, Name,
                (SELECT Id, FirstName, LastName, Phone FROM Contacts)
            FROM Account
            WHERE Id = :recordId
        ];
        results.add(new List<SObject>(accounts));

        // Campaign + CampaignMembers
        List<SObject> campaigns = [
            SELECT Id, Name,
                (SELECT Id, FirstName, LastName, Phone FROM CampaignMembers)
            FROM Campaign
            WHERE Id = :recordId
        ];
        results.add(new List<SObject>(campaigns));

        // Opportunity + OpportunityTeamMembers
        List<SObject> opportunities = [
            SELECT Id, Name, StageName,
                (SELECT Id, User.FirstName, User.LastName, User.Phone FROM OpportunityTeamMembers)
            FROM Opportunity
            WHERE Id = :recordId
        ];
        results.add(new List<SObject>(opportunities));

        return results;
    }

}