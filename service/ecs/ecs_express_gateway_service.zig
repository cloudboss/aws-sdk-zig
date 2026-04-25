const ExpressGatewayServiceConfiguration = @import("express_gateway_service_configuration.zig").ExpressGatewayServiceConfiguration;
const ExpressGatewayServiceStatus = @import("express_gateway_service_status.zig").ExpressGatewayServiceStatus;
const Tag = @import("tag.zig").Tag;

/// Represents an Express service, which provides a simplified way to deploy
/// containerized web applications on Amazon ECS with managed Amazon Web
/// Services infrastructure. An Express service automatically provisions and
/// manages Application Load Balancers, target groups, security groups, and
/// auto-scaling policies.
///
/// Express services use a service revision architecture where each service can
/// have multiple active configurations, enabling blue-green deployments and
/// gradual rollouts. The service maintains a list of active configurations and
/// manages the lifecycle of the underlying Amazon Web Services resources.
pub const ECSExpressGatewayService = struct {
    /// The list of active service configurations for the Express service.
    active_configurations: ?[]const ExpressGatewayServiceConfiguration = null,

    /// The short name or full ARN of the cluster that hosts the Express service.
    cluster: ?[]const u8 = null,

    /// The Unix timestamp for when the Express service was created.
    created_at: ?i64 = null,

    /// The current deployment configuration for the Express service.
    current_deployment: ?[]const u8 = null,

    /// The ARN of the infrastructure role that manages Amazon Web Services
    /// resources for the Express service.
    infrastructure_role_arn: ?[]const u8 = null,

    /// The ARN that identifies the Express service.
    service_arn: ?[]const u8 = null,

    /// The name of the Express service.
    service_name: ?[]const u8 = null,

    /// The current status of the Express service.
    status: ?ExpressGatewayServiceStatus = null,

    /// The metadata applied to the Express service.
    tags: ?[]const Tag = null,

    /// The Unix timestamp for when the Express service was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .active_configurations = "activeConfigurations",
        .cluster = "cluster",
        .created_at = "createdAt",
        .current_deployment = "currentDeployment",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .service_arn = "serviceArn",
        .service_name = "serviceName",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
