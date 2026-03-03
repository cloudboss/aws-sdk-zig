const ContactFlowAttributeFilter = @import("contact_flow_attribute_filter.zig").ContactFlowAttributeFilter;
const ControlPlaneTagFilter = @import("control_plane_tag_filter.zig").ControlPlaneTagFilter;

/// Filters to be applied to search results.
pub const ContactFlowSearchFilter = struct {
    /// Flow attribute filter for contact flow search operations.
    flow_attribute_filter: ?ContactFlowAttributeFilter = null,

    tag_filter: ?ControlPlaneTagFilter = null,

    pub const json_field_names = .{
        .flow_attribute_filter = "FlowAttributeFilter",
        .tag_filter = "TagFilter",
    };
};
