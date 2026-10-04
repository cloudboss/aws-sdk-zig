const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreNetworkPolicy = @import("core_network_policy.zig").CoreNetworkPolicy;

pub const PutCoreNetworkPolicyInput = struct {
    /// The client token associated with the request.
    client_token: ?[]const u8 = null,

    /// The ID of a core network.
    core_network_id: []const u8,

    /// a core network policy description.
    description: ?[]const u8 = null,

    /// The ID of a core network policy.
    latest_version_id: ?i32 = null,

    /// The policy document.
    policy_document: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .description = "Description",
        .latest_version_id = "LatestVersionId",
        .policy_document = "PolicyDocument",
    };
};

pub const PutCoreNetworkPolicyOutput = struct {
    /// Describes the changed core network policy.
    core_network_policy: ?CoreNetworkPolicy = null,

    pub const json_field_names = .{
        .core_network_policy = "CoreNetworkPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutCoreNetworkPolicyInput, options: CallOptions) !PutCoreNetworkPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutCoreNetworkPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/core-networks/");
    try path_buf.appendSlice(allocator, input.core_network_id);
    try path_buf.appendSlice(allocator, "/core-network-policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.latest_version_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LatestVersionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutCoreNetworkPolicyOutput {
    const result: PutCoreNetworkPolicyOutput = try aws.json.parseJsonObject(
        PutCoreNetworkPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
