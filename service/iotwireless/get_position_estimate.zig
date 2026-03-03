const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CellTowers = @import("cell_towers.zig").CellTowers;
const Gnss = @import("gnss.zig").Gnss;
const Ip = @import("ip.zig").Ip;
const WiFiAccessPoint = @import("wi_fi_access_point.zig").WiFiAccessPoint;

pub const GetPositionEstimateInput = struct {
    /// Retrieves an estimated device position by resolving measurement data from
    /// cellular
    /// radio towers. The position is resolved using HERE's cellular-based solver.
    cell_towers: ?CellTowers = null,

    /// Retrieves an estimated device position by resolving the global navigation
    /// satellite
    /// system (GNSS) scan data. The position is resolved using the GNSS solver
    /// powered by LoRa
    /// Cloud.
    gnss: ?Gnss = null,

    /// Retrieves an estimated device position by resolving the IP address
    /// information from
    /// the device. The position is resolved using MaxMind's IP-based solver.
    ip: ?Ip = null,

    /// Optional information that specifies the time when the position information
    /// will be
    /// resolved. It uses the Unix timestamp format. If not specified, the time at
    /// which the
    /// request was received will be used.
    timestamp: ?i64 = null,

    /// Retrieves an estimated device position by resolving WLAN measurement data.
    /// The
    /// position is resolved using HERE's Wi-Fi based solver.
    wi_fi_access_points: ?[]const WiFiAccessPoint = null,

    pub const json_field_names = .{
        .cell_towers = "CellTowers",
        .gnss = "Gnss",
        .ip = "Ip",
        .timestamp = "Timestamp",
        .wi_fi_access_points = "WiFiAccessPoints",
    };
};

pub const GetPositionEstimateOutput = struct {
    /// The position information of the resource, displayed as a JSON payload. The
    /// payload is
    /// of type blob and uses the [GeoJSON](https://geojson.org/) format,
    /// which a format that's used to encode geographic data structures. A sample
    /// payload
    /// contains the timestamp information, the WGS84 coordinates of the location,
    /// and the
    /// accuracy and confidence level. For more information and examples, see
    /// [Resolve device location
    /// (console)](https://docs.aws.amazon.com/iot/latest/developerguide/location-resolve-console.html).
    geo_json_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .geo_json_payload = "GeoJsonPayload",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPositionEstimateInput, options: Options) !GetPositionEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotwireless");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetPositionEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotwireless", "IoT Wireless", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/position-estimate";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cell_towers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CellTowers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.gnss) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Gnss\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Ip\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Timestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.wi_fi_access_points) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WiFiAccessPoints\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPositionEstimateOutput {
    var result: GetPositionEstimateOutput = .{};
    if (body.len > 0) {
        result.geo_json_payload = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
