const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Connection = @import("connection.zig").Connection;

pub const UpdateConnectionInput = struct {
    /// The ID of the link for the second device in the connection.
    connected_link_id: ?[]const u8 = null,

    /// The ID of the connection.
    connection_id: []const u8,

    /// A description of the connection.
    ///
    /// Length Constraints: Maximum length of 256 characters.
    description: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: []const u8,

    /// The ID of the link for the first device in the connection.
    link_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .connected_link_id = "ConnectedLinkId",
        .connection_id = "ConnectionId",
        .description = "Description",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
    };
};

pub const UpdateConnectionOutput = struct {
    /// Information about the connection.
    connection: ?Connection = null,

    pub const json_field_names = .{
        .connection = "Connection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectionInput, options: CallOptions) !UpdateConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-networks/");
    try path_buf.appendSlice(allocator, input.global_network_id);
    try path_buf.appendSlice(allocator, "/connections/");
    try path_buf.appendSlice(allocator, input.connection_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.link_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectionOutput {
    var result: UpdateConnectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateConnectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
