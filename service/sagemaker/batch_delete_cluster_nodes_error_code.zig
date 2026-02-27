pub const BatchDeleteClusterNodesErrorCode = enum {
    node_id_not_found,
    invalid_node_status,
    node_id_in_use,

    pub const json_field_names = .{
        .node_id_not_found = "NODE_ID_NOT_FOUND",
        .invalid_node_status = "INVALID_NODE_STATUS",
        .node_id_in_use = "NODE_ID_IN_USE",
    };
};
