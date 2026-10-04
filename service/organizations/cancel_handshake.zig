const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Handshake = @import("handshake.zig").Handshake;

pub const CancelHandshakeInput = struct {
    /// ID for the handshake that you want to cancel. You can get the ID from the
    /// ListHandshakesForOrganization operation.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for handshake ID string
    /// requires "h-"
    /// followed by from 8 to 32 lowercase letters or digits.
    handshake_id: []const u8,

    pub const json_field_names = .{
        .handshake_id = "HandshakeId",
    };
};

pub const CancelHandshakeOutput = struct {
    /// A `Handshake` object. Contains for the handshake that you canceled.
    handshake: ?Handshake = null,

    pub const json_field_names = .{
        .handshake = "Handshake",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelHandshakeInput, options: CallOptions) !CancelHandshakeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelHandshakeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CancelHandshake");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelHandshakeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CancelHandshakeOutput, body, allocator);
}
