const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// Filters to be applied to search results.
pub const EvaluationSearchFilter = struct {
    attribute_filter: ?ControlPlaneAttributeFilter = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
