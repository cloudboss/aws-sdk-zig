const Visibility = @import("visibility.zig").Visibility;

/// The configuration of the search options in a hierarchy list control.
pub const HierarchyFilterListControlSearchOptions = struct {
    /// The visibility configuration of the search options in a hierarchy list
    /// control.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
