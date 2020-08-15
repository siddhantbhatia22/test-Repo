trigger HelloWorld on Account (After insert) {

    List<Contact> conLst = new List<Contact>();
        for(Account acc : Trigger.new){

            Contact con1 = new Contact();
            con1.LastName = 'sid'+' '+ acc.Name;
            con1.AccountId = acc.id;
            conLst.add(con1);

            Contact con2 = new Contact();
            con2.LastName = 'sid2'+' '+ acc.Name;
            con2.AccountId = acc.id;
            conLst.add(con2);
        }
           insert conLst;
    
}