const aws = @import("aws");

const ServiceEndpointType = @import("service_endpoint_type.zig").ServiceEndpointType;
const ErrorResponse = @import("error_response.zig").ErrorResponse;
const LambdaEndpointSummary = @import("lambda_endpoint_summary.zig").LambdaEndpointSummary;
const ServiceState = @import("service_state.zig").ServiceState;
const UrlEndpointSummary = @import("url_endpoint_summary.zig").UrlEndpointSummary;

/// A summary for the service as a response to `ListServices`.
pub const ServiceSummary = struct {
    /// The unique identifier of the application.
    application_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the service.
    arn: ?[]const u8,

    /// The Amazon Web Services account ID of the service creator.
    created_by_account_id: ?[]const u8,

    /// A timestamp that indicates when the service is created.
    created_time: ?i64,

    /// A description of the service.
    description: ?[]const u8,

    /// The endpoint type of the service.
    endpoint_type: ?ServiceEndpointType,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8,

    /// Any error associated with the service resource.
    @"error": ?ErrorResponse,

    /// A summary of the configuration for the Lambda endpoint type.
    lambda_endpoint: ?LambdaEndpointSummary,

    /// A timestamp that indicates when the service was last updated.
    last_updated_time: ?i64,

    /// The name of the service.
    name: ?[]const u8,

    /// The Amazon Web Services account ID of the service owner.
    owner_account_id: ?[]const u8,

    /// The unique identifier of the service.
    service_id: ?[]const u8,

    /// The current state of the service.
    state: ?ServiceState,

    /// The tags assigned to the service.
    tags: ?[]const aws.map.StringMapEntry,

    /// The summary of the configuration for the URL endpoint type.
    url_endpoint: ?UrlEndpointSummary,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .created_by_account_id = "CreatedByAccountId",
        .created_time = "CreatedTime",
        .description = "Description",
        .endpoint_type = "EndpointType",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .lambda_endpoint = "LambdaEndpoint",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .owner_account_id = "OwnerAccountId",
        .service_id = "ServiceId",
        .state = "State",
        .tags = "Tags",
        .url_endpoint = "UrlEndpoint",
        .vpc_id = "VpcId",
    };
};
