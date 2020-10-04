/*
    Copyright (c) 2020, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.org
* @date 2020
* @group Relationships
* @group-content ../../ApexDocContent/Relationships.htm
* @description Test class for SRVC_ReciprocalRelationshipInversion.
*/
@isTest
private class SRVC_ReciprocalRelInversion_TEST {
    /**************************************************************************************************************************
    * @description Test method to verify that the getInstance method returns a new instance of the 
    * SRVC_ReciprocalRelationshipInversion class when one does not already exist.
    ***************************************************************************************************************************/
    @isTest
    private static void getInstanceNewTest() {
        SRVC_ReciprocalRelationshipInversion srvcReciprocalRelationshipInversionInstance = SRVC_ReciprocalRelationshipInversion.getInstance();
        System.assertEquals(SRVC_ReciprocalRelationshipInversion.instance, srvcReciprocalRelationshipInversionInstance, 'Instance of service class returned should match static instance variable.');
        System.assertEquals(true, srvcReciprocalRelationshipInversionInstance != null, 'Instance of service class should not be null.');
    }

    /**************************************************************************************************************************
    * @description Test method to verify that the getInstance method returns the existing instance of the 
    * SRVC_ReciprocalRelationshipInversion class when one already exists.
    ***************************************************************************************************************************/
    @isTest
    private static void getInstanceExistingTest() {
        SRVC_ReciprocalRelationshipInversion srvcReciprocalRelationshipInversionInstance1 = SRVC_ReciprocalRelationshipInversion.getInstance();
        SRVC_ReciprocalRelationshipInversion srvcReciprocalRelationshipInversionInstance2 = SRVC_ReciprocalRelationshipInversion.getInstance();
 
        System.assertEquals(SRVC_ReciprocalRelationshipInversion.instance, srvcReciprocalRelationshipInversionInstance1, 'Instance of service class returned should match static instance variable.');
        System.assertEquals(srvcReciprocalRelationshipInversionInstance1, srvcReciprocalRelationshipInversionInstance2, 'Subsequent retrievals of service class instance should return existing instance.');
        System.assertEquals(true, srvcReciprocalRelationshipInversionInstance1 != null, 'Instance of service class should not be null.');
    }

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is a string with hyphen in the middle.
    ***************************************************************************************************************************/
    @isTest
    private static void getInversedRelationshipWithHyphenMiddleTest() {
        String relationshipType = 'abc-def';
 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType(relationshipType);
        Test.stopTest();

        System.assertEquals('def-abc', inversedRelationshipType);
    }

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is a string with hyphen at the end.
    ***************************************************************************************************************************/
    @isTest
    private static void getInversedRelationshipWithHyphenEndTest() {
        String relationshipType = 'abc-';
 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType(relationshipType);
        Test.stopTest();

        System.assertEquals('abc', inversedRelationshipType);
    }

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is a string with hyphen at the beginning.
    ***************************************************************************************************************************/
    @isTest
    private static void getInversedRelationshipWithHyphenBeginTest() {
        String relationshipType = '-def';
 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType(relationshipType);
        Test.stopTest();

        System.assertEquals('def-', inversedRelationshipType);
    }

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is a string with only hyphen.
    ***************************************************************************************************************************/
    /*@isTest
    private static void getInversedRelationshipWithOnlyHyphenTest() {
        String relationshipType = '-';
 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType(relationshipType);
        Test.stopTest();

        System.assertEquals('-', inversedRelationshipType);
    }TODO: this is currently a bug or at least we are not preventing users from entering only hyphen*/ 

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is empty string.
    ***************************************************************************************************************************/
    @isTest
    private static void getInversedRelationshipWithEmptyStringTest() { 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType('');
        Test.stopTest();

        System.assertEquals('', inversedRelationshipType);
    }

    /**************************************************************************************************************************
    * @description Test for getInversedRelationship when the relationship type is a string with hyphen in the middle.
    ***************************************************************************************************************************/
    /*@isTest
    private static void getInversedRelationshipWithMoreThanTwoRelMiddleTest() {
        String relationshipType = 'abc-def-ghi';
 
        Test.startTest();
            String inversedRelationshipType = SRVC_ReciprocalRelationshipInversion.getInstance().getInversedRelationshipType(relationshipType);
        Test.stopTest();

        System.assertEquals('def-abc', inversedRelationshipType);
    }TODO: this is currently a bug. The result returns def-abc and we are not preventing users from entering long relationship type*/

    /**************************************************************************************************************************
    * @description Test method for getRelationshipsToUpdateForContacts() if relationships exist
    ***************************************************************************************************************************/
    @isTest
    private static void getRelationshipsToUpdateForContactsRelationshipsExistHyphenMiddleTest() {
        Contact fatherContact = UTIL_UnitTestData_TEST.getContact();
        Contact sonContact = UTIL_UnitTestData_TEST.getContact();
        insert new List<Contact>{fatherContact, sonContact};

        Map<Id, Contact> newContactRelationshipToUpdateByIdMap = new Map<Id, Contact>();
        newContactRelationshipToUpdateByIdMap.put(fatherContact.Id, fatherContact);

        Relationship__c fatherSonRelationship = UTIL_UnitTestData_TEST.getRelationship(sonContact.Id, fatherContact.Id, 'Father-Son');
        insert fatherSonRelationship;

        List<Relationship__c> relationships = [SELECT ID,
                                                    Contact__c,
                                                    RelatedContact__c,
                                                    ReciprocalRelationship__c,
                                                    Type__c     
                                                FROM Relationship__c];
        Map<Id, Relationship__c> relationshipsByIdToUpdateMap = new Map<Id, Relationship__c>(relationships);

        Test.startTest();
        List<Relationship__c> relationshipsToUpdateList = SRVC_ReciprocalRelationshipInversion.getInstance().getRelationshipsToUpdateForContacts(newContactRelationshipToUpdateByIdMap, relationshipsByIdToUpdateMap);
        Test.stopTest();
        
        System.assertEquals(1, relationshipsToUpdateList.size());
        System.assertEquals(fatherSonRelationship.Id, relationshipsToUpdateList[0].Id);
        System.assertEquals('Son-Father', relationshipsToUpdateList[0].Type__c);
    }

    /**************************************************************************************************************************
    * @description Test method for getRelationshipsToUpdateForContacts() if no relationship exists
    ***************************************************************************************************************************/
    @isTest
    private static void getRelationshipsToUpdateForContactsNoRelationshipTest() {
        Test.startTest();
            List<Relationship__c> relationshipsToUpdateList = SRVC_ReciprocalRelationshipInversion.getInstance().getRelationshipsToUpdateForContacts(new Map<Id,Contact>(), new Map<Id, Relationship__c>());
        Test.stopTest();
        
        System.assertEquals(0, relationshipsToUpdateList.size());
    }
}