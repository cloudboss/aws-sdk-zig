const Visibility = @import("visibility.zig").Visibility;

/// The options that determine the presentation of the progress bar of a KPI
/// visual.
pub const ProgressBarOptions = struct {
    /// The visibility of the progress bar.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
