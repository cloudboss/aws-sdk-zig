const DimensionLabelType = @import("dimension_label_type.zig").DimensionLabelType;

/// A label used to group or categorize pricing dimensions, such as by region or
/// SageMaker option.
pub const DimensionLabel = struct {
    /// The human-readable display name of the label.
    display_name: ?[]const u8 = null,

    /// The type of the dimension label, such as `Region` or `SagemakerOption`.
    label_type: DimensionLabelType,

    /// The value used to group dimensions together.
    label_value: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .label_type = "labelType",
        .label_value = "labelValue",
    };
};
