const IngressPathSummary = @import("ingress_path_summary.zig").IngressPathSummary;
const ExpressGatewayServiceNetworkConfiguration = @import("express_gateway_service_network_configuration.zig").ExpressGatewayServiceNetworkConfiguration;
const ExpressGatewayContainer = @import("express_gateway_container.zig").ExpressGatewayContainer;
const ExpressGatewayScalingTarget = @import("express_gateway_scaling_target.zig").ExpressGatewayScalingTarget;

/// Represents a specific configuration revision of an Express service,
/// containing all the
/// settings and parameters for that revision.
pub const ExpressGatewayServiceConfiguration = struct {
    /// The CPU allocation for tasks in this service revision.
    cpu: ?[]const u8 = null,

    /// The Unix timestamp for when this service revision was created.
    created_at: ?i64 = null,

    /// The ARN of the task execution role for the service revision.
    execution_role_arn: ?[]const u8 = null,

    /// The health check path for this service revision.
    health_check_path: ?[]const u8 = null,

    /// The entry point into this service revision.
    ingress_paths: ?[]const IngressPathSummary = null,

    /// The memory allocation for tasks in this service revision.
    memory: ?[]const u8 = null,

    /// The network configuration for tasks in this service revision.
    network_configuration: ?ExpressGatewayServiceNetworkConfiguration = null,

    /// The primary container configuration for this service revision.
    primary_container: ?ExpressGatewayContainer = null,

    /// The auto-scaling configuration for this service revision.
    scaling_target: ?ExpressGatewayScalingTarget = null,

    /// The ARN of the service revision.
    service_revision_arn: ?[]const u8 = null,

    /// The ARN of the task role for the service revision.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu = "cpu",
        .created_at = "createdAt",
        .execution_role_arn = "executionRoleArn",
        .health_check_path = "healthCheckPath",
        .ingress_paths = "ingressPaths",
        .memory = "memory",
        .network_configuration = "networkConfiguration",
        .primary_container = "primaryContainer",
        .scaling_target = "scalingTarget",
        .service_revision_arn = "serviceRevisionArn",
        .task_role_arn = "taskRoleArn",
    };
};
