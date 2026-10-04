const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionState = @import("connection_state.zig").ConnectionState;

pub const DeauthorizeConnectionInput = struct {
    /// The name of the connection to remove authorization from.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DeauthorizeConnectionOutput = struct {
    /// The ARN of the connection that authorization was removed from.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// A time stamp for the time that the connection was last authorized.
    last_authorized_time: ?i64 = null,

    /// A time stamp for the time that the connection was last updated.
    last_modified_time: ?i64 = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .last_authorized_time = "LastAuthorizedTime",
        .last_modified_time = "LastModifiedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeauthorizeConnectionInput, options: CallOptions) !DeauthorizeConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeauthorizeConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DeauthorizeConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeauthorizeConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeauthorizeConnectionOutput, body, allocator);
}
