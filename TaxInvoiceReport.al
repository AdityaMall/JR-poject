report 50127 "Tax Invoice"
{
    Caption = 'TAX Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './BizGrpReport.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            DataItemTableView = SORTING("No.");

            RequestFilterFields = "No.";
            column(CompanyInfo; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_vat; CompanyInfo."VAT Registration No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Order_Date; "Order Date")
            {
            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }



            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Bill_to_Contact; "Bill-to Contact")
            {
            }
            column(Bill_to_County; "Bill-to County")
            {
            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {
            }

            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Bal__Account_Type; "Bal. Account Type")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Salesperson_Name; RecSalesperson.Name)
            {
            }

            column(Payment_Method_Code; "Payment Method Code")
            {

            }
            column(billtofulladress; billtofulladress)
            {

            }
            column(Shiptofulladress; Shiptofulladress)
            {

            }
            column(Order_No_; "Order No.")
            {

            }
            column("BankAccount_No"; CompanyInfo."Bank Account No.")
            {
            }
            column(IBAN; CompanyInfo.IBAN)
            {
            }
            column("Bank_Name"; CompanyInfo."Bank Name")
            {
            }
            column(Bank_Address; CompanyInfo.Address)
            {
            }
            column("Swift_code"; CompanyInfo."SWIFT Code")
            {
            }
            column(name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {

            }
            column(bankaccount_name; companyinfo."Bank Name")
            {

            }
            column(bankaccount_iban; companyinfo.IBAN)
            {

            }
            column(bankaccount_adress; bankaccount.Address)
            {

            }
            column(bankaccount_swift; companyinfo."SWIFT Code")
            {

            }
            column(Customer_vat; Customer."VAT Registration No.")
            {

            }

            column(CompanyInfo_vatreg; CompanyInfo."VAT Registration No.")
            {

            }



            trigger OnAfterGetRecord()
            begin

                if RecSalesperson.Get("Sales Invoice Header"."Salesperson Code") then;
                billtofulladress := StrSubstNo('%1 %2 %3 %4 %5', "bill-to name", "Bill-to Address", "Bill-to Address 2", "Bill-to City", "Bill-to Country/Region Code");
                Shiptofulladress := StrSubstNo('%1 %2 %3 %4 %5', "Ship-to Name", "Ship-to Address", "Ship-to Address 2", "Ship-to City", "Ship-to Country/Region Code");
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                if bankaccount.get(CompanyInfo."Bank Account No.") then;
                if Customer.get("Bill-to Customer No.") then;

            end;
        }


        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {


            DataItemLink = "Document No." = field("No.");
            DataItemLinkReference = "Sales Invoice Header";
            DataItemTableView = SORTING("Document No.", "Line No.");

            column(Description; Description)
            {
            }
            column(Job_No_; "Job No.")
            {
            }
            column(VAT; "VAT %")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Unit_Price; "Unit Price")
            {

            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {

            }

            /*  trigger OnAfterGetRecord()
              begin
                  CompanyInfo.Get();
                  CompanyInfo.CalcFields(Picture);

              end;*/
        }
    }

    var
        CompanyInfo: Record "Company Information";
        RecSalesperson: Record "Salesperson/Purchaser";
        billtofulladress: Text[250];
        bankaccount: Record "Bank Account";
        Shiptofulladress: text[250];
        Customer: Record Customer;



    trigger OnPreReport()
    var

    begin


    end;



}