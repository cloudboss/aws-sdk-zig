const Visibility = @import("visibility.zig").Visibility;

/// The maximum label of a data path label.
pub const MaximumLabelType = struct {
    /// The visibility of the maximum label.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
