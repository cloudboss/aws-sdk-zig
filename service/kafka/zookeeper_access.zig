/// Access control settings for zookeeper
pub const ZookeeperAccess = struct {
    /// Zookeeper Access was on or off for the cluster
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
