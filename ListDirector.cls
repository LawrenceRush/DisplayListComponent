public class ListDirector {
    // Map linking object API names (e.g., 'Account') to their respective builder instances
    private Map<String, BuilderInterface> listBuilderByObjectApiName;
    
    // Finder instance used to fetch records and their related child records
    private Finder finder = new Finder();

    // Constructor initializes the map with the builder objects for each relevant Salesforce object
    public ListDirector() {
        listBuilderByObjectApiName = new Map<String, BuilderInterface>{
            'Account' => new ContactListBuilder(),
            'Campaign' => new CampaignMemberListBuilder(),
            'Opportunity' => new OpportunityTeamListBuilder()
        };
    }

    /**
     * Main method to choose the appropriate builder based on the record Id.
     * 1. Gets the SObject record using getRecordById.
     * 2. Finds the object API name from the record.
     * 3. Retrieves the corresponding builder from the map.
     * 4. Passes the record to the builder and returns the builder instance.
     */
    public BuilderInterface chooseList(Id recordId) {
        // Retrieve the full SObject record (with related children) for the given Id
        SObject record = getRecordById(String.valueOf(recordId));
        
        // Get the API name of the object's type (e.g., 'Account', 'Campaign')
        String objApiName = record.getSObjectType().getDescribe().getName();
        
        // Get the builder corresponding to this object type from the map
        BuilderInterface builder = listBuilderByObjectApiName.get(objApiName);
        
        // Provide the record to the builder for further processing
        builder.setSObject(record);
        
        // Return the builder instance for later use (e.g., calling build())
        return builder;
    }

    /**
     * Retrieves the SObject record (and its child records) given the string UUID.
     * Uses the Finder class's findList method to get all related records.
     * Returns the first non-empty record found.
     */
    public SObject getRecordById(String uuid) {
        // Convert the string UUID to a Salesforce Id type
        Id recordId = Id.valueOf(uuid);
        
        // Use the Finder class to retrieve all related records as lists of SObjects
        List<List<SObject>> allResults = finder.findList(recordId);

        // Loop through each list returned and return the first non-empty one
        for (List<SObject> sObjList : allResults) {
            if (sObjList == null || sObjList.isEmpty()) {
                continue; // Skip empty lists
            }
            return sObjList[0]; // Return the first SObject found
        }
        
        // Return null if no records found (should rarely happen with valid Ids)
        return null;
    }
}
