const Visibility = @import("visibility.zig").Visibility;

/// The label options of the label that is displayed in the center of a donut
/// chart. This option isn't available for pie charts.
pub const DonutCenterOptions = struct {
    /// Determines the visibility of the label in a donut chart. In the Quick Sight
    /// console, this option is called `'Show total'`.
    label_visibility: ?Visibility,

    pub const json_field_names = .{
        .label_visibility = "LabelVisibility",
    };
};
