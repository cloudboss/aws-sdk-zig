const Visibility = @import("visibility.zig").Visibility;

/// The minimum label of a data path label.
pub const MinimumLabelType = struct {
    /// The visibility of the minimum label.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
