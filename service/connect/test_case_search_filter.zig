const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// Filters to be applied to search results.
pub const TestCaseSearchFilter = struct {
    /// An object that can be used to specify Tag conditions inside the
    /// SearchFilter. This accepts an OR of AND (List of List) input where: Top
    /// level list specifies conditions that need to be applied with OR operator.
    /// Inner list specifies conditions that need to be applied with AND operator.
    tag_filter: ?ControlPlaneTagFilter = null,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
    };
};
