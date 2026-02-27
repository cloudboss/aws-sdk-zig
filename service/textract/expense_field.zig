const ExpenseCurrency = @import("expense_currency.zig").ExpenseCurrency;
const ExpenseGroupProperty = @import("expense_group_property.zig").ExpenseGroupProperty;
const ExpenseDetection = @import("expense_detection.zig").ExpenseDetection;
const ExpenseType = @import("expense_type.zig").ExpenseType;

/// Breakdown of detected information, seperated into
/// the catagories Type, LabelDetection, and ValueDetection
pub const ExpenseField = struct {
    /// Shows the kind of currency, both the code and confidence associated with any
    /// monatary value
    /// detected.
    currency: ?ExpenseCurrency,

    /// Shows which group a response object belongs to, such as whether an address
    /// line
    /// belongs to the vendor's address or the recipent's address.
    group_properties: ?[]const ExpenseGroupProperty,

    /// The explicitly stated label of a detected element.
    label_detection: ?ExpenseDetection,

    /// The page number the value was detected on.
    page_number: ?i32,

    /// The implied label of a detected element. Present alongside LabelDetection
    /// for explicit elements.
    type: ?ExpenseType,

    /// The value of a detected element. Present in explicit and implicit elements.
    value_detection: ?ExpenseDetection,

    pub const json_field_names = .{
        .currency = "Currency",
        .group_properties = "GroupProperties",
        .label_detection = "LabelDetection",
        .page_number = "PageNumber",
        .type = "Type",
        .value_detection = "ValueDetection",
    };
};
