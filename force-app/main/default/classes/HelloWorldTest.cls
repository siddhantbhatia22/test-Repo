@isTest
private class HelloWorldTest {
    @isTest static void HelloWorldTest() {
      Account acc = new Account();
      acc.Name = 'Test';
      insert acc;   
    }
}