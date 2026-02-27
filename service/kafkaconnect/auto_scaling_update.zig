const ScaleInPolicyUpdate = @import("scale_in_policy_update.zig").ScaleInPolicyUpdate;
const ScaleOutPolicyUpdate = @import("scale_out_policy_update.zig").ScaleOutPolicyUpdate;

/// The updates to the auto scaling parameters for the connector.
pub const AutoScalingUpdate = struct {
    /// The target maximum number of workers allocated to the connector.
    max_worker_count: i32 = 0,

    /// The target number of microcontroller units (MCUs) allocated to each
    /// connector worker. The valid values are 1,2,4,8.
    mcu_count: i32 = 0,

    /// The target minimum number of workers allocated to the connector.
    min_worker_count: i32 = 0,

    /// The target sacle-in policy for the connector.
    scale_in_policy: ScaleInPolicyUpdate,

    /// The target sacle-out policy for the connector.
    scale_out_policy: ScaleOutPolicyUpdate,

    pub const json_field_names = .{
        .max_worker_count = "maxWorkerCount",
        .mcu_count = "mcuCount",
        .min_worker_count = "minWorkerCount",
        .scale_in_policy = "scaleInPolicy",
        .scale_out_policy = "scaleOutPolicy",
    };
};
