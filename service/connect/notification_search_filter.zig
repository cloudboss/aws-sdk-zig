const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// Filters to apply when searching for notifications.
pub const NotificationSearchFilter = struct {
    /// Attribute-based filters to apply to the search results.
    attribute_filter: ?ControlPlaneAttributeFilter = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
