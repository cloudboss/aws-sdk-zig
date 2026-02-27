const Visibility = @import("visibility.zig").Visibility;

/// The configuration of the `Select all` options in a list control.
pub const ListControlSelectAllOptions = struct {
    /// The visibility configuration of the `Select all` options in a list control.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
