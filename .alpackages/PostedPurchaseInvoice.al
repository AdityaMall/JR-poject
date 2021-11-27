pageextension 50350 postedpurchaseinvoice extends "posted sales invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action("Print Invoice")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    salesinvoiceheader.Reset();
                    salesinvoiceheader.SetRange("No.", "No.");
                    Report.RunModal(50126, true, false, salesinvoiceheader);
                end;

            }
        }
    }

    var
        myInt: Integer;
        salesinvoiceheader: Record "Sales Invoice Header";
}