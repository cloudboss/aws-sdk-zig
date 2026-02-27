/// An association representing a case rule acting upon a field. In the Amazon
/// Connect admin website, case rules are known as *case field conditions*. For
/// more information about case field conditions, see [Add case field conditions
/// to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const TemplateRule = struct {
    /// Unique identifier of a case rule.
    case_rule_id: []const u8,

    /// Unique identifier of a field.
    field_id: []const u8 = "NULL",

    pub const json_field_names = .{
        .case_rule_id = "caseRuleId",
        .field_id = "fieldId",
    };
};
