/// The structure that stores the capacity configuration details of a scaling
/// group.
pub const KxScalingGroupConfiguration = struct {
    /// The number of vCPUs that you want to reserve for each node of this kdb
    /// cluster on the scaling group host.
    cpu: ?f64 = null,

    /// An optional hard limit on the amount of memory a kdb cluster can use.
    memory_limit: ?i32 = null,

    /// A reservation of the minimum amount of memory that should be available on
    /// the scaling group for a kdb cluster to be successfully placed in a scaling
    /// group.
    memory_reservation: i32,

    /// The number of kdb cluster nodes.
    node_count: i32,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: []const u8,

    pub const json_field_names = .{
        .cpu = "cpu",
        .memory_limit = "memoryLimit",
        .memory_reservation = "memoryReservation",
        .node_count = "nodeCount",
        .scaling_group_name = "scalingGroupName",
    };
};
