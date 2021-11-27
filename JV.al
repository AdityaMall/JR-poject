report 50108 JV
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Journal Voucher';
    DefaultLayout = RDLC;
    RDLCLayout = './Journal Voucher-Test.rdl';




    dataset
    {

        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            //DataItemLinkReference = GenJournalBatch;
            // DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Name");


            // DataItemTableView = sorting("Document No.");
            RequestFilterFields = "Journal Template Name", "Document No.";
            column(Document_No_; "Document No.")
            {

            }
            column(Posting_Date; "Posting Date") { }
            column(Account_No_; "Account No.") { }
            column(Description; Description) { }
            column(Dimension1; Dimension1) { }
            column(Dimension2; Dimension2) { }
            column(Debit_Amount; "Debit Amount") { }
            column(Credit_Amount; "Credit Amount") { }
            column(Amount__LCY_; "Amount (LCY)") { }
            column(Amountinwords; Amountinwords) { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
               // Caption = '1,2,3';
            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
                //Caption = '1,2,3';
            }
            column(Txt; Txt) { }
            column(CompName; Companyinfo.Name) { }
            column(CompPicture; Companyinfo.Picture)
            {

            }
            column(CompanyinfoName; Companyinfo.Name)
            {

            }
            column(CompanyinfoName2; Companyinfo."Name 2")
            {

            }
            column(Address; Address)
            {

            }
            column(FullUsername; FullUsername)
            {

            }
            column(dim1; dim1) { }
            column(dim2; dim2) { }

            trigger OnAfterGetRecord()
            begin
                GenJournalLine.SETRANGE("Document No.", "Document No.");
                IF GenJournalLine.FindSet THEN
                    Repeat

                        AmtGl += ABS(GenJournalLine."Debit Amount");
                    UNTIL GenJournalLine.NEXT = 0;


                Amount := AmtGl;
                //ROUND(AmtGl, 0.01);

                Repcheck.InitTextVariable;

                Repcheck.FormatNoText(NoText, Amount, "Gen. Journal Line"."Currency Code");

                AmountInWords := NoText[1];

                GLSetup.GET;
                //DimensionSetEntry.RESET;

                //DimensionSetEntry.SETRANGE("Dimension Set ID", "Gen. Journal Line"."Dimension Set ID");


                // IF DimensionSetEntry.FINDFIRST THEN BEGIN

                //  DimensionSetEntry.CALCFIELDS("Dimension Value Name");

                // Dimension1 := DimensionSetEntry."Dimension Value Name";




                // END;

                // DimensionSetEntry.SETRANGE("Dimension Set ID", "Gen. Journal Line"."Dimension Set ID");
                //IF DimensionSetEntry.FINDLAST THEN BEGIN
                //   DimensionSetEntry.CALCFIELDS("Dimension Value Name");
                //  Dimension2 := DimensionSetEntry."Dimension Value Name";

                // END;
                GenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
                IF GenJournalLine."Journal Template Name" = 'GENERAL' THEN
                    txt := 'Journal'
                ELSE
                    IF GenJournalLine."Journal Template Name" = 'CASH RECE' THEN
                        txt := 'Cash Receipt'

                    ELSE
                        IF GenJournalLine."Journal Template Name" = 'PAYMENTS' THEN
                            txt := 'Payment'
                        else
                            if GenJournalLine."Journal Template Name" = 'BANK PAYME' then
                                txt := 'Bank Payment'
                            else
                                if GenJournalLine."Journal Template Name" = 'BANK RECEI' then
                                    txt := 'Bank Receipt'
                                else
                                    if GenJournalLine."Journal Template Name" = 'CASH PAYME' then
                                        txt := 'Cash Payment'
                                    else
                                        if GenJournalLine."Journal Template Name" = 'CASH RECEI' then
                                            txt := 'Cash Receipt';



                ResCenter.SetRange(Code, GenJournalLine."Responsibility Center");
                if ResCenter.FindFirst() then
                    // Address:=ResCenter.Address;
                    Adress2 := ResCenter."Address 2" + ' ' + ResCenter.City + ' ' + ResCenter.County + ResCenter.Contact;
                Address := STRSUBSTNO('%1 %2', Adress2, ResCenter.Address);
                USer.SetRange("User Name", UserId);
                if USer.FindFirst() then
                    FullUsername := USer."Full Name";

                Companyinfo.Get;
                Companyinfo.CalcFields(Picture);

                GLSetup.Reset();
                dim1 := GLSetup."Global Dimension 1 Code";
                dim2 := GLSetup."Global Dimension 2 Code";
            end;


        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        Dimension1: Text;
        Dimension2: Text;

        Companyinfo: Record "Company Information";
        AmtGl: Decimal;
        Repcheck: Report Check;
        NoText: array[2] of text;
        DimensionSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        AmountInWords: Text[250];
        GenJournalLine: Record "Gen. Journal Line";
        Amount: Decimal;
        Txt: Text[50];
        dim1: text[50];
        dim2: text[50];
        ResCenter: Record "Responsibility Center";
        Address: text[100];
        Adress2: text[100];
        ZipCode: text[50];
        city: text[50];
        USer: Record User;
        FullUsername: text[100];

}