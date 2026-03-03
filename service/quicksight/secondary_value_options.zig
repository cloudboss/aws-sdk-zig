const Visibility = @import("visibility.zig").Visibility;

/// The options that determine the presentation of the secondary value of a KPI
/// visual.
pub const SecondaryValueOptions = struct {
    /// Determines the visibility of the secondary value.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
