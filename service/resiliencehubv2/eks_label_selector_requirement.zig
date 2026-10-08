const EksLabelSelectorOperator = @import("eks_label_selector_operator.zig").EksLabelSelectorOperator;

/// A single label requirement in a label selector, expressed as a key, an
/// operator, and an optional list of values.
pub const EksLabelSelectorRequirement = struct {
    /// The label key that the requirement applies to.
    key: []const u8,

    /// The operator that relates the label key to the values.
    operator: EksLabelSelectorOperator,

    /// The label values to compare against. Specify values when the operator is IN
    /// or NOT_IN. Leave this empty when the operator is EXISTS or DOES_NOT_EXIST.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .operator = "operator",
        .values = "values",
    };
};
