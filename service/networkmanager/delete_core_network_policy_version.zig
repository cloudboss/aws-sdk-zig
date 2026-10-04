const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreNetworkPolicy = @import("core_network_policy.zig").CoreNetworkPolicy;

pub const DeleteCoreNetworkPolicyVersionInput = struct {
    /// The ID of a core network for the deleted policy.
    core_network_id: []const u8,

    /// The version ID of the deleted policy.
    policy_version_id: i32,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .policy_version_id = "PolicyVersionId",
    };
};

pub const DeleteCoreNetworkPolicyVersionOutput = struct {
    /// Returns information about the deleted policy version.
    core_network_policy: ?CoreNetworkPolicy = null,

    pub const json_field_names = .{
        .core_network_policy = "CoreNetworkPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCoreNetworkPolicyVersionInput, options: CallOptions) !DeleteCoreNetworkPolicyVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCoreNetworkPolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/core-networks/");
    try path_buf.appendSlice(allocator, input.core_network_id);
    try path_buf.appendSlice(allocator, "/core-network-policy-versions/");
    try path_buf.appendSlice(allocator, input.policy_version_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCoreNetworkPolicyVersionOutput {
    const result: DeleteCoreNetworkPolicyVersionOutput = try aws.json.parseJsonObject(
        DeleteCoreNetworkPolicyVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
