const RepairAction = @import("repair_action.zig").RepairAction;

/// Specify granular overrides for specific repair actions. These overrides
/// control the
/// repair action and the repair delay time before a node is considered eligible
/// for repair.
/// If you use this, you must specify all the values.
pub const NodeRepairConfigOverrides = struct {
    /// Specify the minimum time in minutes to wait before attempting to repair a
    /// node
    /// with this specific `nodeMonitoringCondition` and
    /// `nodeUnhealthyReason`.
    min_repair_wait_time_mins: ?i32,

    /// Specify an unhealthy condition reported by the node monitoring agent that
    /// this
    /// override would apply to.
    node_monitoring_condition: ?[]const u8,

    /// Specify a reason reported by the node monitoring agent that this
    /// override would apply to.
    node_unhealthy_reason: ?[]const u8,

    /// Specify the repair action to take for nodes when all of the specified
    /// conditions are
    /// met.
    repair_action: ?RepairAction,

    pub const json_field_names = .{
        .min_repair_wait_time_mins = "minRepairWaitTimeMins",
        .node_monitoring_condition = "nodeMonitoringCondition",
        .node_unhealthy_reason = "nodeUnhealthyReason",
        .repair_action = "repairAction",
    };
};
