/// The auto scaling configuration settings for a service managed EC2 fleet.
pub const ServiceManagedEc2AutoScalingConfiguration = struct {
    /// The number of workers that can be added per minute to the fleet. The default
    /// is a service-defined value that balances efficiency with cost.
    scale_out_workers_per_minute: ?i32 = null,

    /// The number of idle workers maintained and ready to process incoming tasks.
    /// The default is 0.
    standby_worker_count: ?i32 = null,

    /// The number of seconds that a worker can remain idle before it is shut down.
    /// The default is 300 seconds (5 minutes).
    worker_idle_duration_seconds: i32 = 300,

    pub const json_field_names = .{
        .scale_out_workers_per_minute = "scaleOutWorkersPerMinute",
        .standby_worker_count = "standbyWorkerCount",
        .worker_idle_duration_seconds = "workerIdleDurationSeconds",
    };
};
