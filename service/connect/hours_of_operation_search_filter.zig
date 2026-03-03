const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// Filters to be applied to search results.
pub const HoursOfOperationSearchFilter = struct {
    tag_filter: ?ControlPlaneTagFilter = null,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
    };
};
