const Visibility = @import("visibility.zig").Visibility;

/// The field label type.
pub const FieldLabelType = struct {
    /// Indicates the field that is targeted by the field
    /// label.
    field_id: ?[]const u8 = null,

    /// The visibility of the field label.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .visibility = "Visibility",
    };
};
