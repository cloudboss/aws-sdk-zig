const EvaluationFormItemSourceValuesComparator = @import("evaluation_form_item_source_values_comparator.zig").EvaluationFormItemSourceValuesComparator;
const EvaluationFormItemEnablementSource = @import("evaluation_form_item_enablement_source.zig").EvaluationFormItemEnablementSource;
const EvaluationFormItemEnablementSourceValue = @import("evaluation_form_item_enablement_source_value.zig").EvaluationFormItemEnablementSourceValue;

/// An expression that defines a basic building block of conditional enablement.
pub const EvaluationFormItemEnablementExpression = struct {
    /// A comparator to be used against list of values.
    comparator: EvaluationFormItemSourceValuesComparator,

    /// A source item of enablement expression.
    source: EvaluationFormItemEnablementSource,

    /// A list of values from source item.
    values: []const EvaluationFormItemEnablementSourceValue,

    pub const json_field_names = .{
        .comparator = "Comparator",
        .source = "Source",
        .values = "Values",
    };
};
