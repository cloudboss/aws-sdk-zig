const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApiDestinationState = @import("api_destination_state.zig").ApiDestinationState;
const ApiDestinationHttpMethod = @import("api_destination_http_method.zig").ApiDestinationHttpMethod;

pub const DescribeApiDestinationInput = struct {
    /// The name of the API destination to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeApiDestinationOutput = struct {
    /// The ARN of the API destination retrieved.
    api_destination_arn: ?[]const u8 = null,

    /// The state of the API destination retrieved.
    api_destination_state: ?ApiDestinationState = null,

    /// The ARN of the connection specified for the API destination retrieved.
    connection_arn: ?[]const u8 = null,

    /// A time stamp for the time that the API destination was created.
    creation_time: ?i64 = null,

    /// The description for the API destination retrieved.
    description: ?[]const u8 = null,

    /// The method to use to connect to the HTTP endpoint.
    http_method: ?ApiDestinationHttpMethod = null,

    /// The URL to use to connect to the HTTP endpoint.
    invocation_endpoint: ?[]const u8 = null,

    /// The maximum number of invocations per second to specified for the API
    /// destination. Note
    /// that if you set the invocation rate maximum to a value lower the rate
    /// necessary to send all
    /// events received on to the destination HTTP endpoint, some events may not be
    /// delivered within
    /// the 24-hour retry window. If you plan to set the rate lower than the rate
    /// necessary to deliver
    /// all events, consider using a dead-letter queue to catch events that are not
    /// delivered within
    /// 24 hours.
    invocation_rate_limit_per_second: ?i32 = null,

    /// A time stamp for the time that the API destination was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the API destination retrieved.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_destination_arn = "ApiDestinationArn",
        .api_destination_state = "ApiDestinationState",
        .connection_arn = "ConnectionArn",
        .creation_time = "CreationTime",
        .description = "Description",
        .http_method = "HttpMethod",
        .invocation_endpoint = "InvocationEndpoint",
        .invocation_rate_limit_per_second = "InvocationRateLimitPerSecond",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApiDestinationInput, options: CallOptions) !DescribeApiDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApiDestinationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeApiDestination");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApiDestinationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeApiDestinationOutput, body, allocator);
}
