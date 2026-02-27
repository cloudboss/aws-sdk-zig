const MonitoringConstraintsResource = @import("monitoring_constraints_resource.zig").MonitoringConstraintsResource;

/// Configuration for monitoring constraints and monitoring statistics. These
/// baseline resources are compared against the results of the current job from
/// the series of jobs scheduled to collect data periodically.
pub const ModelQualityBaselineConfig = struct {
    /// The name of the job that performs baselining for the monitoring job.
    baselining_job_name: ?[]const u8,

    constraints_resource: ?MonitoringConstraintsResource,

    pub const json_field_names = .{
        .baselining_job_name = "BaseliningJobName",
        .constraints_resource = "ConstraintsResource",
    };
};
