pub const BatchReplaceClusterNodesErrorCode = enum {
    instance_id_not_found,
    invalid_instance_status,
    instance_id_in_use,
    internal_server_error,

    pub const json_field_names = .{
        .instance_id_not_found = "INSTANCE_ID_NOT_FOUND",
        .invalid_instance_status = "INVALID_INSTANCE_STATUS",
        .instance_id_in_use = "INSTANCE_ID_IN_USE",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };
};
