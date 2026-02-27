/// Describes a deployment pattern version summary.
pub const DeploymentPatternVersionDataSummary = struct {
    /// The name of the deployment pattern.
    deployment_pattern_name: ?[]const u8,

    /// The name of the deployment pattern version.
    deployment_pattern_version_name: ?[]const u8,

    /// The description of the deployment pattern version.
    description: ?[]const u8,

    /// The URL of the documentation for the deployment pattern version.
    documentation_url: ?[]const u8,

    /// The name of the workload.
    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .deployment_pattern_name = "deploymentPatternName",
        .deployment_pattern_version_name = "deploymentPatternVersionName",
        .description = "description",
        .documentation_url = "documentationUrl",
        .workload_name = "workloadName",
    };
};
