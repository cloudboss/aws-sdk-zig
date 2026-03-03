const ExpenseDocument = @import("expense_document.zig").ExpenseDocument;
const IdentityDocument = @import("identity_document.zig").IdentityDocument;
const LendingDocument = @import("lending_document.zig").LendingDocument;

/// Contains information extracted by an analysis operation after using
/// StartLendingAnalysis.
pub const Extraction = struct {
    expense_document: ?ExpenseDocument = null,

    identity_document: ?IdentityDocument = null,

    /// Holds the structured data returned by AnalyzeDocument for lending documents.
    lending_document: ?LendingDocument = null,

    pub const json_field_names = .{
        .expense_document = "ExpenseDocument",
        .identity_document = "IdentityDocument",
        .lending_document = "LendingDocument",
    };
};
