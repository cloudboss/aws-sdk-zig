const IoTJobAbortConfig = @import("io_t_job_abort_config.zig").IoTJobAbortConfig;
const IoTJobExecutionsRolloutConfig = @import("io_t_job_executions_rollout_config.zig").IoTJobExecutionsRolloutConfig;
const IoTJobTimeoutConfig = @import("io_t_job_timeout_config.zig").IoTJobTimeoutConfig;

/// Contains information about an IoT job configuration.
pub const DeploymentIoTJobConfiguration = struct {
    /// The stop configuration for the job. This configuration defines when and how
    /// to stop a job
    /// rollout.
    abort_config: ?IoTJobAbortConfig = null,

    /// The rollout configuration for the job. This configuration defines the rate
    /// at which the
    /// job rolls out to the fleet of target devices.
    job_executions_rollout_config: ?IoTJobExecutionsRolloutConfig = null,

    /// The timeout configuration for the job. This configuration defines the amount
    /// of time each
    /// device has to complete the job.
    timeout_config: ?IoTJobTimeoutConfig = null,

    pub const json_field_names = .{
        .abort_config = "abortConfig",
        .job_executions_rollout_config = "jobExecutionsRolloutConfig",
        .timeout_config = "timeoutConfig",
    };
};
