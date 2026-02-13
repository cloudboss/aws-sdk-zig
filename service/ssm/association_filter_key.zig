pub const AssociationFilterKey = enum {
    instance_id,
    name,
    association_id,
    status,
    last_executed_before,
    last_executed_after,
    association_name,
    resource_group_name,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .name = "Name",
        .association_id = "AssociationId",
        .status = "Status",
        .last_executed_before = "LastExecutedBefore",
        .last_executed_after = "LastExecutedAfter",
        .association_name = "AssociationName",
        .resource_group_name = "ResourceGroupName",
    };
};
