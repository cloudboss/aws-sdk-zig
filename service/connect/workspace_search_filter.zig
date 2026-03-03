const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// Defines filters to apply when searching for workspaces, such as tag-based
/// filters.
pub const WorkspaceSearchFilter = struct {
    attribute_filter: ?ControlPlaneAttributeFilter = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
