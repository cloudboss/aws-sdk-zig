pub const AssociationExecutionTargetsFilterKey = enum {
    status,
    resource_id,
    resource_type,

    pub const json_field_names = .{
        .status = "Status",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
