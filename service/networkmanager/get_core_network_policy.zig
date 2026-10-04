const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreNetworkPolicyAlias = @import("core_network_policy_alias.zig").CoreNetworkPolicyAlias;
const CoreNetworkPolicy = @import("core_network_policy.zig").CoreNetworkPolicy;

pub const GetCoreNetworkPolicyInput = struct {
    /// The alias of a core network policy
    alias: ?CoreNetworkPolicyAlias = null,

    /// The ID of a core network.
    core_network_id: []const u8,

    /// The ID of a core network policy version.
    policy_version_id: ?i32 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .core_network_id = "CoreNetworkId",
        .policy_version_id = "PolicyVersionId",
    };
};

pub const GetCoreNetworkPolicyOutput = struct {
    /// The details about a core network policy.
    core_network_policy: ?CoreNetworkPolicy = null,

    pub const json_field_names = .{
        .core_network_policy = "CoreNetworkPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCoreNetworkPolicyInput, options: CallOptions) !GetCoreNetworkPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCoreNetworkPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/core-networks/");
    try path_buf.appendSlice(allocator, input.core_network_id);
    try path_buf.appendSlice(allocator, "/core-network-policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.alias) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "alias=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.policy_version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "policyVersionId=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCoreNetworkPolicyOutput {
    const result: GetCoreNetworkPolicyOutput = try aws.json.parseJsonObject(
        GetCoreNetworkPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
