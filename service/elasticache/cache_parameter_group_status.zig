/// Status of the cache parameter group.
pub const CacheParameterGroupStatus = struct {
    /// A list of the cache node IDs which need to be rebooted for parameter changes
    /// to be
    /// applied. A node ID is a numeric identifier (0001, 0002, etc.).
    cache_node_ids_to_reboot: ?[]const []const u8,

    /// The name of the cache parameter group.
    cache_parameter_group_name: ?[]const u8,

    /// The status of parameter updates.
    parameter_apply_status: ?[]const u8,
};
