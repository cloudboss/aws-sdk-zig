const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecuteCoreNetworkChangeSetInput = struct {
    /// The ID of a core network.
    core_network_id: []const u8,

    /// The ID of the policy version.
    policy_version_id: i32,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .policy_version_id = "PolicyVersionId",
    };
};

pub const ExecuteCoreNetworkChangeSetOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteCoreNetworkChangeSetInput, options: CallOptions) !ExecuteCoreNetworkChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteCoreNetworkChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/core-networks/");
    try path_buf.appendSlice(allocator, input.core_network_id);
    try path_buf.appendSlice(allocator, "/core-network-change-sets/");
    try path_buf.appendSlice(allocator, input.policy_version_id);
    try path_buf.appendSlice(allocator, "/execute");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteCoreNetworkChangeSetOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ExecuteCoreNetworkChangeSetOutput = .{};

    return result;
}
