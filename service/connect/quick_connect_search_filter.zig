const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// Filters to be applied to search results.
pub const QuickConnectSearchFilter = struct {
    tag_filter: ?ControlPlaneTagFilter,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
    };
};
