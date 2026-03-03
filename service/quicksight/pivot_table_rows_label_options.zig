const Visibility = @import("visibility.zig").Visibility;

/// The options for the label thta is located above the row headers. This option
/// is only applicable when `RowsLayout` is set to `HIERARCHY`.
pub const PivotTableRowsLabelOptions = struct {
    /// The custom label string for the rows label.
    custom_label: ?[]const u8 = null,

    /// The visibility of the rows label.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .custom_label = "CustomLabel",
        .visibility = "Visibility",
    };
};
