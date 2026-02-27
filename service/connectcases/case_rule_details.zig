const FieldOptionsCaseRule = @import("field_options_case_rule.zig").FieldOptionsCaseRule;
const HiddenCaseRule = @import("hidden_case_rule.zig").HiddenCaseRule;
const RequiredCaseRule = @import("required_case_rule.zig").RequiredCaseRule;

/// Represents what rule type should take place, under what conditions. In the
/// Amazon Connect admin website, case rules are known as *case field
/// conditions*. For more information about case field conditions, see [Add case
/// field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const CaseRuleDetails = union(enum) {
    /// Which options are available in a child field based on the selected value in
    /// a parent field.
    field_options: ?FieldOptionsCaseRule,
    /// Whether a field is visible, based on values in other fields.
    hidden: ?HiddenCaseRule,
    /// Required rule type, used to indicate whether a field is required.
    required: ?RequiredCaseRule,

    pub const json_field_names = .{
        .field_options = "fieldOptions",
        .hidden = "hidden",
        .required = "required",
    };
};
