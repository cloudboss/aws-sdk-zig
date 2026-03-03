/// Information about the instance topology.
pub const InstanceTopology = struct {
    /// The name of the Availability Zone or Local Zone that the instance is in.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Capacity Block. This parameter is only supported for
    /// UltraServer
    /// instances and identifies instances within the UltraServer domain.
    capacity_block_id: ?[]const u8 = null,

    /// The name of the placement group that the instance is in.
    group_name: ?[]const u8 = null,

    /// The instance ID.
    instance_id: ?[]const u8 = null,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The network nodes. The nodes are hashed based on your account. Instances
    /// from
    /// different accounts running under the same server will return a different
    /// hashed list of
    /// strings.
    ///
    /// The value is `null` or empty if:
    ///
    /// * The instance type is not supported.
    ///
    /// * The instance is in a state other than `running`.
    network_nodes: ?[]const []const u8 = null,

    /// The ID of the Availability Zone or Local Zone that the instance is in.
    zone_id: ?[]const u8 = null,
};
