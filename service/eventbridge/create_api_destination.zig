const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiDestinationHttpMethod = @import("api_destination_http_method.zig").ApiDestinationHttpMethod;
const ApiDestinationState = @import("api_destination_state.zig").ApiDestinationState;

pub const CreateApiDestinationInput = struct {
    /// The ARN of the connection to use for the API destination. The destination
    /// endpoint must
    /// support the authorization type specified for the connection.
    connection_arn: []const u8,

    /// A description for the API destination to create.
    description: ?[]const u8 = null,

    /// The method to use for the request to the HTTP invocation endpoint.
    http_method: ApiDestinationHttpMethod,

    /// The URL to the HTTP invocation endpoint for the API destination.
    invocation_endpoint: []const u8,

    /// The maximum number of requests per second to send to the HTTP invocation
    /// endpoint.
    invocation_rate_limit_per_second: ?i32 = null,

    /// The name for the API destination to create.
    name: []const u8,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .description = "Description",
        .http_method = "HttpMethod",
        .invocation_endpoint = "InvocationEndpoint",
        .invocation_rate_limit_per_second = "InvocationRateLimitPerSecond",
        .name = "Name",
    };
};

pub const CreateApiDestinationOutput = struct {
    /// The ARN of the API destination that was created by the request.
    api_destination_arn: ?[]const u8 = null,

    /// The state of the API destination that was created by the request.
    api_destination_state: ?ApiDestinationState = null,

    /// A time stamp indicating the time that the API destination was created.
    creation_time: ?i64 = null,

    /// A time stamp indicating the time that the API destination was last modified.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .api_destination_arn = "ApiDestinationArn",
        .api_destination_state = "ApiDestinationState",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiDestinationInput, options: CallOptions) !CreateApiDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "events", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApiDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "EventBridge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.CreateApiDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApiDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateApiDestinationOutput, body, allocator);
}
