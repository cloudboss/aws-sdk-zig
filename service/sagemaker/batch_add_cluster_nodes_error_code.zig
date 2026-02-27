pub const BatchAddClusterNodesErrorCode = enum {
    instance_group_not_found,
    invalid_instance_group_status,

    pub const json_field_names = .{
        .instance_group_not_found = "INSTANCE_GROUP_NOT_FOUND",
        .invalid_instance_group_status = "INVALID_INSTANCE_GROUP_STATUS",
    };
};
