const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MultiplexSettings = @import("multiplex_settings.zig").MultiplexSettings;
const Multiplex = @import("multiplex.zig").Multiplex;

pub const CreateMultiplexInput = struct {
    /// A list of availability zones for the multiplex. You must specify exactly
    /// two.
    availability_zones: []const []const u8,

    /// Configuration for a multiplex event.
    multiplex_settings: MultiplexSettings,

    /// Name of multiplex.
    name: []const u8,

    /// Unique request ID. This prevents retries from creating multiple
    /// resources.
    request_id: []const u8,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .multiplex_settings = "MultiplexSettings",
        .name = "Name",
        .request_id = "RequestId",
        .tags = "Tags",
    };
};

pub const CreateMultiplexOutput = struct {
    /// The newly created multiplex.
    multiplex: ?Multiplex = null,

    pub const json_field_names = .{
        .multiplex = "Multiplex",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMultiplexInput, options: CallOptions) !CreateMultiplexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMultiplexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prod/multiplexes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AvailabilityZones\":");
    try aws.json.writeValue(@TypeOf(input.availability_zones), input.availability_zones, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MultiplexSettings\":");
    try aws.json.writeValue(@TypeOf(input.multiplex_settings), input.multiplex_settings, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RequestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMultiplexOutput {
    var result: CreateMultiplexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMultiplexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
