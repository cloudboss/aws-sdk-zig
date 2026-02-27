const OtaTaskAbortConfig = @import("ota_task_abort_config.zig").OtaTaskAbortConfig;
const OtaTaskExecutionRolloutConfig = @import("ota_task_execution_rollout_config.zig").OtaTaskExecutionRolloutConfig;
const OtaTaskTimeoutConfig = @import("ota_task_timeout_config.zig").OtaTaskTimeoutConfig;

/// Structure representing a push config.
pub const PushConfig = struct {
    /// Structure representing one abort config.
    abort_config: ?OtaTaskAbortConfig,

    /// Structure representing one rollout config.
    rollout_config: ?OtaTaskExecutionRolloutConfig,

    /// Structure representing one timeout config.
    timeout_config: ?OtaTaskTimeoutConfig,

    pub const json_field_names = .{
        .abort_config = "AbortConfig",
        .rollout_config = "RolloutConfig",
        .timeout_config = "TimeoutConfig",
    };
};
