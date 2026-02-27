const Visibility = @import("visibility.zig").Visibility;

/// The option that specifies individual data values for labels.
pub const DataPathLabelType = struct {
    /// The field ID of the field that the data label needs to be applied to.
    field_id: ?[]const u8,

    /// The actual value of the field that is labeled.
    field_value: ?[]const u8,

    /// The visibility of the data label.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .field_value = "FieldValue",
        .visibility = "Visibility",
    };
};
