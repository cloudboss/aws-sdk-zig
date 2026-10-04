const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Connection = @import("connection.zig").Connection;

pub const CreateConnectionInput = struct {
    /// The ID of the second device in the connection.
    connected_device_id: []const u8,

    /// The ID of the link for the second device.
    connected_link_id: ?[]const u8 = null,

    /// A description of the connection.
    ///
    /// Length Constraints: Maximum length of 256 characters.
    description: ?[]const u8 = null,

    /// The ID of the first device in the connection.
    device_id: []const u8,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link for the first device.
    link_id: ?[]const u8 = null,

    /// The tags to apply to the resource during creation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connected_device_id = "ConnectedDeviceId",
        .connected_link_id = "ConnectedLinkId",
        .description = "Description",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .tags = "Tags",
    };
};

pub const CreateConnectionOutput = struct {
    /// Information about the connection.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "Connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/connections");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConnectedDeviceId\":");
    try aws.json.writeValue(@TypeOf(input.connected_device_id), input.connected_device_id, allocator, &body_buf);
    has_prev = true;
    if (input.connected_link_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectedLinkId\":");
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
    try body_buf.appendSlice(allocator, "\"DeviceId\":");
    try aws.json.writeValue(@TypeOf(input.device_id), input.device_id, allocator, &body_buf);
    has_prev = true;
    if (input.link_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    var result: CreateConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
