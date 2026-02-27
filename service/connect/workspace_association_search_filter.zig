const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// Defines filters to apply when searching for workspace associations, such as
/// tag-based filters.
pub const WorkspaceAssociationSearchFilter = struct {
    attribute_filter: ?ControlPlaneAttributeFilter,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
