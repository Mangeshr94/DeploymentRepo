/**
 * This class is used for creating contacts for the given list of accounts and updating the account description to 'Completed'.
    Version: 1.0
 */
public with Sharing class demoClass1 {
/**
 * Creates contacts & update Account 
 */
    public static void createContacts(List<Account> accounts){
List<Contact> contactsToInsert = new List<Contact>();
List<Account> accountsToUpdate = new List<Account>();
        for(Account acc : accounts){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            contactsToInsert.add(con);
            acc.Description = 'Completed';
            accountsToUpdate.add(acc);

        } 
        try{
            if(Schema.sObjectType.Contact.isCreateable()){
                insert contactsToInsert;
            }
            if(Schema.sObjectType.Account.isUpdateable()){
                update accountsToUpdate;
            }
        }
        catch(DmlException e){
            System.debug('An error occurred while creating contacts or updating accounts: ' + e.getMessage());
        }
    }
}