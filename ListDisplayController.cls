public with sharing class ListDisplayController {
    
    /**
     * Method to be called by the LWC (ListDisplay) to build a list
     * @param recordId - The Id of the record from which to build the list
     * @return Object - The final built list from the chosen builder  * @param recordId - The Id of the record from which to build the list
     * @return Object - The final built list from the chosen builder
     * @return Object - The final built list from the chosen build
     */
    @AuraEnabled(cacheable=true)
    public static Object buildList(Id recordId) {
        // Create an instance of the ListDirector
        ListDirector director = new ListDirector();
        // Use the director to choose the appropriate list builder based on recordId
        BuilderInterface builder = director.chooseList(recordId);
        
        // Call the build() method on the builder to produce the list
        system.debug(builder.build());
        return builder.build();
    }
}
