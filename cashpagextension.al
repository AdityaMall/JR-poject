pageextension 50120 MyExtension1 extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bal. Account Name")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addfirst(navigation)
        {
            action("JV Print")
            {
                Caption = 'JV Print';
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    GenJnl.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnl.SetRange("Document No.", "Document No.");
                    Report.RunModal(50107, true, FALSE, GenJnl);
                end;

            }
        }
    }

    var
        GenJnl: Record "Gen. Journal Line";
}