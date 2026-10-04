const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiplexSettings = @import("multiplex_settings.zig").MultiplexSettings;
const MultiplexProgramPacketIdentifiersMap = @import("multiplex_program_packet_identifiers_map.zig").MultiplexProgramPacketIdentifiersMap;
const Multiplex = @import("multiplex.zig").Multiplex;

pub const UpdateMultiplexInput = struct {
    /// ID of the multiplex to update.
    multiplex_id: []const u8,

    /// The new settings for a multiplex.
    multiplex_settings: ?MultiplexSettings = null,

    /// Name of the multiplex.
    name: ?[]const u8 = null,

    packet_identifiers_mapping: ?[]const aws.map.MapEntry(MultiplexProgramPacketIdentifiersMap) = null,

    pub const json_field_names = .{
        .multiplex_id = "MultiplexId",
        .multiplex_settings = "MultiplexSettings",
        .name = "Name",
        .packet_identifiers_mapping = "PacketIdentifiersMapping",
    };
};

pub const UpdateMultiplexOutput = struct {
    /// The updated multiplex.
    multiplex: ?Multiplex = null,

    pub const json_field_names = .{
        .multiplex = "Multiplex",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMultiplexInput, options: CallOptions) !UpdateMultiplexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMultiplexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/multiplexes/");
    try path_buf.appendSlice(allocator, input.multiplex_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.multiplex_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MultiplexSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.packet_identifiers_mapping) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PacketIdentifiersMapping\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMultiplexOutput {
    const result: UpdateMultiplexOutput = try aws.json.parseJsonObject(
        UpdateMultiplexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
