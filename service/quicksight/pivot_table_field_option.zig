const Visibility = @import("visibility.zig").Visibility;

/// The selected field options for the pivot table field options.
pub const PivotTableFieldOption = struct {
    /// The custom label of the pivot table field.
    custom_label: ?[]const u8,

    /// The field ID of the pivot table field.
    field_id: []const u8,

    /// The visibility of the pivot table field.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .field_id = "FieldId",
        .visibility = "Visibility",
    };
};
