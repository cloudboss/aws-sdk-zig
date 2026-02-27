const ScaleInPolicyDescription = @import("scale_in_policy_description.zig").ScaleInPolicyDescription;
const ScaleOutPolicyDescription = @import("scale_out_policy_description.zig").ScaleOutPolicyDescription;

/// Information about the auto scaling parameters for the connector.
pub const AutoScalingDescription = struct {
    /// The maximum number of workers allocated to the connector.
    max_worker_count: i32 = 0,

    /// The number of microcontroller units (MCUs) allocated to each connector
    /// worker. The valid values are 1,2,4,8.
    mcu_count: i32 = 0,

    /// The minimum number of workers allocated to the connector.
    min_worker_count: i32 = 0,

    /// The sacle-in policy for the connector.
    scale_in_policy: ?ScaleInPolicyDescription,

    /// The sacle-out policy for the connector.>
    scale_out_policy: ?ScaleOutPolicyDescription,

    pub const json_field_names = .{
        .max_worker_count = "maxWorkerCount",
        .mcu_count = "mcuCount",
        .min_worker_count = "minWorkerCount",
        .scale_in_policy = "scaleInPolicy",
        .scale_out_policy = "scaleOutPolicy",
    };
};
