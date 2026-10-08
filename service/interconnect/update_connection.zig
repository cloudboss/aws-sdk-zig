const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Connection = @import("connection.zig").Connection;

pub const UpdateConnectionInput = struct {
    /// Request a new bandwidth size on the given Connection.
    ///
    /// Note that changes to the size may be subject to additional policy, and does
    /// require the remote partner provider to acknowledge and permit this new
    /// bandwidth size.
    bandwidth: ?[]const u8 = null,

    /// Idempotency token used for the request.
    client_token: ?[]const u8 = null,

    /// An updated description to apply to the Connection
    description: ?[]const u8 = null,

    /// The identifier of the Connection that should be updated.
    identifier: []const u8,

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .client_token = "clientToken",
        .description = "description",
        .identifier = "identifier",
    };
};

pub const UpdateConnectionOutput = struct {
    /// The resulting updated Connection
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectionInput, options: CallOptions) !UpdateConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Interconnect.UpdateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateConnectionOutput, body, allocator);
}
