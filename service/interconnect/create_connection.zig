const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttachPoint = @import("attach_point.zig").AttachPoint;
const RemoteAccountIdentifier = @import("remote_account_identifier.zig").RemoteAccountIdentifier;
const Connection = @import("connection.zig").Connection;

pub const CreateConnectionInput = struct {
    /// The Attach Point to which the connection should be associated."
    attach_point: AttachPoint,

    /// The desired bandwidth of the requested Connection
    bandwidth: []const u8,

    /// Idempotency token used for the request.
    client_token: ?[]const u8 = null,

    /// A description to distinguish this Connection.
    description: ?[]const u8 = null,

    /// The identifier of the Environment across which this Connection should be
    /// created.
    ///
    /// The available Environment objects can be determined using ListEnvironments.
    environment_id: []const u8,

    /// Account and/or principal identifying information that can be verified by the
    /// partner of this specific Environment.
    remote_account: ?RemoteAccountIdentifier = null,

    /// The tag to associate with the resulting Connection.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .attach_point = "attachPoint",
        .bandwidth = "bandwidth",
        .client_token = "clientToken",
        .description = "description",
        .environment_id = "environmentId",
        .remote_account = "remoteAccount",
        .tags = "tags",
    };
};

pub const CreateConnectionOutput = struct {
    /// The resulting Connection.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "interconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("interconnect", "Interconnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Interconnect.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
