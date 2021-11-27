pageextension 50109 MyExtension extends "General Journal"
{
    layout
    {
        addafter(Comment)
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
            action("Vocuher Print")
            {
                Caption = 'JV Print';
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GenJnl.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnl.SetRange("Document No.", "Document No.");
                    Report.RunModal(50108, true, FALSE, GenJnl);
                end;

            }
        }
    }

    var
        GenJnl: Record "Gen. Journal Line";
}