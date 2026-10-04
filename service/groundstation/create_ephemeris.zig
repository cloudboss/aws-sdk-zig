const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EphemerisData = @import("ephemeris_data.zig").EphemerisData;

pub const CreateEphemerisInput = struct {
    /// Set to `true` to enable the ephemeris after validation. Set to `false` to
    /// keep it disabled.
    enabled: ?bool = null,

    /// Ephemeris data.
    ephemeris: ?EphemerisData = null,

    /// An overall expiration time for the ephemeris in UTC, after which it will
    /// become `EXPIRED`.
    expiration_time: ?i64 = null,

    /// The ARN of the KMS key to use for encrypting the ephemeris.
    kms_key_arn: ?[]const u8 = null,

    /// A name that you can use to identify the ephemeris.
    name: []const u8,

    /// A priority score that determines which ephemeris to use when multiple
    /// ephemerides overlap.
    ///
    /// Higher numbers take precedence. The default is 1. Must be 1 or greater.
    priority: ?i32 = null,

    /// The satellite ID that associates this ephemeris with a satellite in AWS
    /// Ground Station.
    satellite_id: ?[]const u8 = null,

    /// Tags assigned to an ephemeris.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .ephemeris = "ephemeris",
        .expiration_time = "expirationTime",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .priority = "priority",
        .satellite_id = "satelliteId",
        .tags = "tags",
    };
};

pub const CreateEphemerisOutput = struct {
    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEphemerisInput, options: CallOptions) !CreateEphemerisOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEphemerisInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ephemeris";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ephemeris) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ephemeris\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expiration_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expirationTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.satellite_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"satelliteId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEphemerisOutput {
    var result: CreateEphemerisOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEphemerisOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
