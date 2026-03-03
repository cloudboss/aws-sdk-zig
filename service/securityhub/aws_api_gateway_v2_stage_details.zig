const aws = @import("aws");

const AwsApiGatewayAccessLogSettings = @import("aws_api_gateway_access_log_settings.zig").AwsApiGatewayAccessLogSettings;
const AwsApiGatewayV2RouteSettings = @import("aws_api_gateway_v2_route_settings.zig").AwsApiGatewayV2RouteSettings;

/// Contains information about a version 2 stage for Amazon API Gateway.
pub const AwsApiGatewayV2StageDetails = struct {
    /// Information about settings for logging access for the stage.
    access_log_settings: ?AwsApiGatewayAccessLogSettings = null,

    /// Indicates whether the stage is managed by API Gateway.
    api_gateway_managed: ?bool = null,

    /// Indicates whether updates to an API automatically trigger a new deployment.
    auto_deploy: ?bool = null,

    /// The identifier of a client certificate for a stage. Supported only for
    /// WebSocket API calls.
    client_certificate_id: ?[]const u8 = null,

    /// Indicates when the stage was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_date: ?[]const u8 = null,

    /// Default route settings for the stage.
    default_route_settings: ?AwsApiGatewayV2RouteSettings = null,

    /// The identifier of the deployment that the stage is associated with.
    deployment_id: ?[]const u8 = null,

    /// The description of the stage.
    description: ?[]const u8 = null,

    /// The status of the last deployment of a stage. Supported only if the stage
    /// has automatic
    /// deployment enabled.
    last_deployment_status_message: ?[]const u8 = null,

    /// Indicates when the stage was most recently updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_updated_date: ?[]const u8 = null,

    /// The route settings for the stage.
    route_settings: ?AwsApiGatewayV2RouteSettings = null,

    /// The name of the stage.
    stage_name: ?[]const u8 = null,

    /// A map that defines the stage variables for the stage.
    ///
    /// Variable names can have alphanumeric and underscore characters.
    ///
    /// Variable values can contain the following characters:
    ///
    /// * Uppercase and lowercase letters
    ///
    /// * Numbers
    ///
    /// * Special characters -._~:/?#&=,
    stage_variables: ?[]const aws.map.StringMapEntry = null,

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
    };
};
