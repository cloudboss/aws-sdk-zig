const Visibility = @import("visibility.zig").Visibility;

/// The configuration of the search options in a list control.
pub const ListControlSearchOptions = struct {
    /// The visibility configuration of the search options in a list control.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
