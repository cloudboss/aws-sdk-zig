const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// The search criteria to be used to return flow modules.
pub const ContactFlowModuleSearchFilter = struct {
    tag_filter: ?ControlPlaneTagFilter = null,

    pub const json_field_names = .{
        .tag_filter = "TagFilter",
    };
};
