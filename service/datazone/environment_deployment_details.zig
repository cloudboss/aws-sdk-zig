const aws = @import("aws");

const EnvironmentError = @import("environment_error.zig").EnvironmentError;
const OverallDeploymentStatus = @import("overall_deployment_status.zig").OverallDeploymentStatus;

/// The environment deployment details.
pub const EnvironmentDeploymentDetails = struct {
    /// Environment failure reasons.
    environment_failure_reasons: ?[]const aws.map.MapEntry([]const EnvironmentError),

    /// The overall deployment status of the environment.
    overall_deployment_status: ?OverallDeploymentStatus,

    pub const json_field_names = .{
        .environment_failure_reasons = "environmentFailureReasons",
        .overall_deployment_status = "overallDeploymentStatus",
    };
};
