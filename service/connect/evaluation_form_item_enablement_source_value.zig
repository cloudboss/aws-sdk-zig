const EvaluationFormItemEnablementSourceValueType = @import("evaluation_form_item_enablement_source_value_type.zig").EvaluationFormItemEnablementSourceValueType;

/// An enablement expression source value.
pub const EvaluationFormItemEnablementSourceValue = struct {
    /// A referenceId of the source value.
    ref_id: ?[]const u8 = null,

    /// A type of source item value.
    @"type": EvaluationFormItemEnablementSourceValueType,

    pub const json_field_names = .{
        .ref_id = "RefId",
        .@"type" = "Type",
    };
};
