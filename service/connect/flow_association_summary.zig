const ListFlowAssociationResourceType = @import("list_flow_association_resource_type.zig").ListFlowAssociationResourceType;

/// Information about flow associations.
pub const FlowAssociationSummary = struct {
    /// The identifier of the flow.
    flow_id: ?[]const u8 = null,

    /// The identifier of the resource.
    resource_id: ?[]const u8 = null,

    /// The type of resource association.
    resource_type: ?ListFlowAssociationResourceType = null,

    pub const json_field_names = .{
        .flow_id = "FlowId",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
