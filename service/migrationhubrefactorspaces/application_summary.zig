const aws = @import("aws");

const ApiGatewayProxySummary = @import("api_gateway_proxy_summary.zig").ApiGatewayProxySummary;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const ProxyType = @import("proxy_type.zig").ProxyType;
const ApplicationState = @import("application_state.zig").ApplicationState;

/// The list of `ApplicationSummary` objects.
pub const ApplicationSummary = struct {
    /// The endpoint URL of the Amazon API Gateway proxy.
    api_gateway_proxy: ?ApiGatewayProxySummary = null,

    /// The unique identifier of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the application.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the application creator.
    created_by_account_id: ?[]const u8 = null,

    /// A timestamp that indicates when the application is created.
    created_time: ?i64 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the application resource.
    @"error": ?ErrorResponse = null,

    /// A timestamp that indicates when the application was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the application owner (which is always
    /// the same as
    /// the environment owner account ID).
    owner_account_id: ?[]const u8 = null,

    /// The proxy type of the proxy created within the application.
    proxy_type: ?ProxyType = null,

    /// The current state of the application.
    state: ?ApplicationState = null,

    /// The tags assigned to the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_gateway_proxy = "ApiGatewayProxy",
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .proxy_type = "ProxyType",
        .state = "State",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};
