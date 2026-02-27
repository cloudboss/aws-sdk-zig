const ScaleInPolicy = @import("scale_in_policy.zig").ScaleInPolicy;
const ScaleOutPolicy = @import("scale_out_policy.zig").ScaleOutPolicy;

/// Specifies how the connector scales.
pub const AutoScaling = struct {
    /// The maximum number of workers allocated to the connector.
    max_worker_count: i32 = 0,

    /// The number of microcontroller units (MCUs) allocated to each connector
    /// worker. The valid values are 1,2,4,8.
    mcu_count: i32 = 0,

    /// The minimum number of workers allocated to the connector.
    min_worker_count: i32 = 0,

    /// The sacle-in policy for the connector.
    scale_in_policy: ?ScaleInPolicy,

    /// The sacle-out policy for the connector.
    scale_out_policy: ?ScaleOutPolicy,

    pub const json_field_names = .{
        .max_worker_count = "maxWorkerCount",
        .mcu_count = "mcuCount",
        .min_worker_count = "minWorkerCount",
        .scale_in_policy = "scaleInPolicy",
        .scale_out_policy = "scaleOutPolicy",
    };
};
