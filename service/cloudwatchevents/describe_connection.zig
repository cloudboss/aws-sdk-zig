const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const ConnectionAuthResponseParameters = @import("connection_auth_response_parameters.zig").ConnectionAuthResponseParameters;
const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const DescribeConnectionInput = struct {
    /// The name of the connection to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeConnectionOutput = struct {
    /// The type of authorization specified for the connection.
    authorization_type: ?ConnectionAuthorizationType = null,

    /// The parameters to use for authorization for the connection.
    auth_parameters: ?ConnectionAuthResponseParameters = null,

    /// The ARN of the connection retrieved.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection retrieved.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// The description for the connection retrieved.
    description: ?[]const u8 = null,

    /// A time stamp for the time that the connection was last authorized.
    last_authorized_time: ?i64 = null,

    /// A time stamp for the time that the connection was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the connection retrieved.
    name: ?[]const u8 = null,

    /// The ARN of the secret created from the authorization parameters specified
    /// for the
    /// connection.
    secret_arn: ?[]const u8 = null,

    /// The reason that the connection is in the current connection state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .auth_parameters = "AuthParameters",
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_authorized_time = "LastAuthorizedTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .secret_arn = "SecretArn",
        .state_reason = "StateReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectionInput, options: CallOptions) !DescribeConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("events", "CloudWatch Events", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConnectionOutput, body, allocator);
}
