const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateEphemerisInput = struct {
    /// Enable or disable the ephemeris. Changing this value doesn't require
    /// re-validation.
    enabled: bool,

    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: []const u8,

    /// A name that you can use to identify the ephemeris.
    name: ?[]const u8 = null,

    /// A priority score that determines which ephemeris to use when multiple
    /// ephemerides overlap.
    ///
    /// Higher numbers take precedence. The default is 1. Must be 1 or greater.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .ephemeris_id = "ephemerisId",
        .name = "name",
        .priority = "priority",
    };
};

pub const UpdateEphemerisOutput = struct {
    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEphemerisInput, options: CallOptions) !UpdateEphemerisOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEphemerisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ephemeris/");
    try path_buf.appendSlice(allocator, input.ephemeris_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"enabled\":");
    try aws.json.writeValue(@TypeOf(input.enabled), input.enabled, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"priority\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEphemerisOutput {
    var result: UpdateEphemerisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEphemerisOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
