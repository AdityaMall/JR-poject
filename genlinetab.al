tableextension 50301 Genlinetab extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50051; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center".Code;
        }
    }

    var
        myInt: Integer;
}