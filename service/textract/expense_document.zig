const Block = @import("block.zig").Block;
const LineItemGroup = @import("line_item_group.zig").LineItemGroup;
const ExpenseField = @import("expense_field.zig").ExpenseField;

/// The structure holding all the information returned by AnalyzeExpense
pub const ExpenseDocument = struct {
    /// This is a block object, the same as reported when DetectDocumentText is run
    /// on a document.
    /// It provides word level recognition of text.
    blocks: ?[]const Block,

    /// Denotes which invoice or receipt in the document the information is coming
    /// from.
    /// First document will be 1, the second 2, and so on.
    expense_index: ?i32,

    /// Information detected on each table of a document, seperated into
    /// `LineItems`.
    line_item_groups: ?[]const LineItemGroup,

    /// Any information found outside of a table by Amazon Textract.
    summary_fields: ?[]const ExpenseField,

    pub const json_field_names = .{
        .blocks = "Blocks",
        .expense_index = "ExpenseIndex",
        .line_item_groups = "LineItemGroups",
        .summary_fields = "SummaryFields",
    };
};
