const aws = @import("aws");

const AccessLogSettings = @import("access_log_settings.zig").AccessLogSettings;
const RouteSettings = @import("route_settings.zig").RouteSettings;

/// Represents an API stage.
pub const Stage = struct {
    /// Settings for logging access in this stage.
    access_log_settings: ?AccessLogSettings,

    /// Specifies whether a stage is managed by API Gateway. If you created an API
    /// using quick create, the $default stage is managed by API Gateway. You can't
    /// modify the $default stage.
    api_gateway_managed: ?bool,

    /// Specifies whether updates to an API automatically trigger a new deployment.
    /// The default value is false.
    auto_deploy: ?bool,

    /// The identifier of a client certificate for a Stage. Supported only for
    /// WebSocket APIs.
    client_certificate_id: ?[]const u8,

    /// The timestamp when the stage was created.
    created_date: ?i64,

    /// Default route settings for the stage.
    default_route_settings: ?RouteSettings,

    /// The identifier of the Deployment that the Stage is associated with. Can't be
    /// updated if autoDeploy is enabled.
    deployment_id: ?[]const u8,

    /// The description of the stage.
    description: ?[]const u8,

    /// Describes the status of the last deployment of a stage. Supported only for
    /// stages with autoDeploy enabled.
    last_deployment_status_message: ?[]const u8,

    /// The timestamp when the stage was last updated.
    last_updated_date: ?i64,

    /// Route settings for the stage, by routeKey.
    route_settings: ?[]const aws.map.MapEntry(RouteSettings),

    /// The name of the stage.
    stage_name: []const u8,

    /// A map that defines the stage variables for a stage resource. Variable names
    /// can have alphanumeric and underscore characters, and the values must match
    /// [A-Za-z0-9-._~:/?#&=,]+.
    stage_variables: ?[]const aws.map.StringMapEntry,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .access_log_settings = "AccessLogSettings",
        .api_gateway_managed = "ApiGatewayManaged",
        .auto_deploy = "AutoDeploy",
        .client_certificate_id = "ClientCertificateId",
        .created_date = "CreatedDate",
        .default_route_settings = "DefaultRouteSettings",
        .deployment_id = "DeploymentId",
        .description = "Description",
        .last_deployment_status_message = "LastDeploymentStatusMessage",
        .last_updated_date = "LastUpdatedDate",
        .route_settings = "RouteSettings",
        .stage_name = "StageName",
        .stage_variables = "StageVariables",
        .tags = "Tags",
    };
};
