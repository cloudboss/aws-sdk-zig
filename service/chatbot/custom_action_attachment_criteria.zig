const CustomActionAttachmentCriteriaOperator = @import("custom_action_attachment_criteria_operator.zig").CustomActionAttachmentCriteriaOperator;

/// A criteria for when a button should be shown based on values in the
/// notification
pub const CustomActionAttachmentCriteria = struct {
    /// The operation to perform on the named variable.
    operator: CustomActionAttachmentCriteriaOperator,

    /// A value that is compared with the actual value of the variable based on the
    /// behavior of the operator.
    value: ?[]const u8,

    /// The name of the variable to operate on.
    variable_name: []const u8,

    pub const json_field_names = .{
        .operator = "Operator",
        .value = "Value",
        .variable_name = "VariableName",
    };
};
