const KxNodeStatus = @import("kx_node_status.zig").KxNodeStatus;

/// A structure that stores metadata for a kdb node.
pub const KxNode = struct {
    /// The identifier of the availability zones where subnets for the environment
    /// are created.
    availability_zone_id: ?[]const u8,

    /// The time when a particular node is started. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    launch_time: ?i64,

    /// A unique identifier for the node.
    node_id: ?[]const u8,

    /// Specifies the status of the cluster nodes.
    ///
    /// * `RUNNING` – The node is actively serving.
    ///
    /// * `PROVISIONING` – The node is being prepared.
    status: ?KxNodeStatus,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .launch_time = "launchTime",
        .node_id = "nodeId",
        .status = "status",
    };
};
