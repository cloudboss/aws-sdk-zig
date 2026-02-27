const MonitoringConstraintsResource = @import("monitoring_constraints_resource.zig").MonitoringConstraintsResource;

/// The configuration for a baseline model bias job.
pub const ModelBiasBaselineConfig = struct {
    /// The name of the baseline model bias job.
    baselining_job_name: ?[]const u8,

    constraints_resource: ?MonitoringConstraintsResource,

    pub const json_field_names = .{
        .baselining_job_name = "BaseliningJobName",
        .constraints_resource = "ConstraintsResource",
    };
};
