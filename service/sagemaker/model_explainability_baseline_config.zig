const MonitoringConstraintsResource = @import("monitoring_constraints_resource.zig").MonitoringConstraintsResource;

/// The configuration for a baseline model explainability job.
pub const ModelExplainabilityBaselineConfig = struct {
    /// The name of the baseline model explainability job.
    baselining_job_name: ?[]const u8 = null,

    constraints_resource: ?MonitoringConstraintsResource = null,

    pub const json_field_names = .{
        .baselining_job_name = "BaseliningJobName",
        .constraints_resource = "ConstraintsResource",
    };
};
