const Visibility = @import("visibility.zig").Visibility;
const VisibleRangeOptions = @import("visible_range_options.zig").VisibleRangeOptions;

/// The visual display options for a data zoom scroll bar.
pub const ScrollBarOptions = struct {
    /// The visibility of the data zoom scroll bar.
    visibility: ?Visibility = null,

    /// The visibility range for the data zoom scroll bar.
    visible_range: ?VisibleRangeOptions = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
        .visible_range = "VisibleRange",
    };
};
