const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;

/// A data table search filter.
pub const DataTableSearchFilter = struct {
    attribute_filter: ?ControlPlaneAttributeFilter,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
    };
};
