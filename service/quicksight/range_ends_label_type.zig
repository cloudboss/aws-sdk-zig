const Visibility = @import("visibility.zig").Visibility;

/// The range ends label type of a data path label.
pub const RangeEndsLabelType = struct {
    /// The visibility of the range ends label.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
