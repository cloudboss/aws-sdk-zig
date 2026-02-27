const ExpenseField = @import("expense_field.zig").ExpenseField;

/// A structure that holds information about the different lines found in a
/// document's tables.
pub const LineItemFields = struct {
    /// ExpenseFields used to show information from detected lines on a table.
    line_item_expense_fields: ?[]const ExpenseField,

    pub const json_field_names = .{
        .line_item_expense_fields = "LineItemExpenseFields",
    };
};
