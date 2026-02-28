const EvaluationFormItemEnablementSourceType = @import("evaluation_form_item_enablement_source_type.zig").EvaluationFormItemEnablementSourceType;

/// An enablement expression source item.
pub const EvaluationFormItemEnablementSource = struct {
    /// A referenceId of the source item.
    ref_id: ?[]const u8,

    /// A type of source item.
    @"type": EvaluationFormItemEnablementSourceType,

    pub const json_field_names = .{
        .ref_id = "RefId",
        .@"type" = "Type",
    };
};
