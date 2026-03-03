const ApiDestinationState = @import("api_destination_state.zig").ApiDestinationState;
const ApiDestinationHttpMethod = @import("api_destination_http_method.zig").ApiDestinationHttpMethod;

/// Contains details about an API destination.
pub const ApiDestination = struct {
    /// The ARN of the API destination.
    api_destination_arn: ?[]const u8 = null,

    /// The state of the API destination.
    api_destination_state: ?ApiDestinationState = null,

    /// The ARN of the connection specified for the API destination.
    connection_arn: ?[]const u8 = null,

    /// A time stamp for the time that the API destination was created.
    creation_time: ?i64 = null,

    /// The method to use to connect to the HTTP endpoint.
    http_method: ?ApiDestinationHttpMethod = null,

    /// The URL to the endpoint for the API destination.
    invocation_endpoint: ?[]const u8 = null,

    /// The maximum number of invocations per second to send to the HTTP endpoint.
    invocation_rate_limit_per_second: ?i32 = null,

    /// A time stamp for the time that the API destination was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the API destination.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_destination_arn = "ApiDestinationArn",
        .api_destination_state = "ApiDestinationState",
        .connection_arn = "ConnectionArn",
        .creation_time = "CreationTime",
        .http_method = "HttpMethod",
        .invocation_endpoint = "InvocationEndpoint",
        .invocation_rate_limit_per_second = "InvocationRateLimitPerSecond",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};
