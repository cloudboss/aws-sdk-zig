const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CoreNetwork = @import("core_network.zig").CoreNetwork;

pub const CreateCoreNetworkInput = struct {
    /// The client token associated with a core network request.
    client_token: ?[]const u8 = null,

    /// The description of a core network.
    description: ?[]const u8 = null,

    /// The ID of the global network that a core network will be a part of.
    global_network_id: []const u8,

    /// The policy document for creating a core network.
    policy_document: ?[]const u8 = null,

    /// Key-value tags associated with a core network request.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .policy_document = "PolicyDocument",
        .tags = "Tags",
    };
};

pub const CreateCoreNetworkOutput = struct {
    /// Returns details about a core network.
    core_network: ?CoreNetwork = null,

    pub const json_field_names = .{
        .core_network = "CoreNetwork",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCoreNetworkInput, options: CallOptions) !CreateCoreNetworkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCoreNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/core-networks";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GlobalNetworkId\":");
    try aws.json.writeValue(@TypeOf(input.global_network_id), input.global_network_id, allocator, &body_buf);
    has_prev = true;
    if (input.policy_document) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyDocument\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCoreNetworkOutput {
    var result: CreateCoreNetworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCoreNetworkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
