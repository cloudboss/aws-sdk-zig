const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GeometryFormat = @import("geometry_format.zig").GeometryFormat;
const RoadSnapTracePoint = @import("road_snap_trace_point.zig").RoadSnapTracePoint;
const RoadSnapTravelMode = @import("road_snap_travel_mode.zig").RoadSnapTravelMode;
const RoadSnapTravelModeOptions = @import("road_snap_travel_mode_options.zig").RoadSnapTravelModeOptions;
const RoadSnapNotice = @import("road_snap_notice.zig").RoadSnapNotice;
const RoadSnapSnappedGeometry = @import("road_snap_snapped_geometry.zig").RoadSnapSnappedGeometry;
const RoadSnapSnappedTracePoint = @import("road_snap_snapped_trace_point.zig").RoadSnapSnappedTracePoint;

pub const SnapToRoadsInput = struct {
    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Chooses what the returned SnappedGeometry format should be.
    ///
    /// Default Value: `FlexiblePolyline`
    snapped_geometry_format: ?GeometryFormat = null,

    /// The radius around the provided tracepoint that is considered for snapping.
    ///
    /// **Unit**: `meters`
    ///
    /// Default value: `300`
    snap_radius: ?i64 = null,

    /// List of trace points to be snapped onto the road network.
    trace_points: []const RoadSnapTracePoint,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// Default Value: `Car`
    travel_mode: ?RoadSnapTravelMode = null,

    /// Travel mode related options for the provided travel mode.
    travel_mode_options: ?RoadSnapTravelModeOptions = null,

    pub const json_field_names = .{
        .key = "Key",
        .snapped_geometry_format = "SnappedGeometryFormat",
        .snap_radius = "SnapRadius",
        .trace_points = "TracePoints",
        .travel_mode = "TravelMode",
        .travel_mode_options = "TravelModeOptions",
    };
};

pub const SnapToRoadsOutput = struct {
    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: ?[]const RoadSnapNotice = null,

    /// The pricing bucket for which the query is charged at.
    pricing_bucket: []const u8,

    /// The interpolated geometry for the snapped route onto the road network.
    snapped_geometry: ?RoadSnapSnappedGeometry = null,

    /// Specifies the format of the geometry returned for each leg of the route.
    snapped_geometry_format: GeometryFormat,

    /// The trace points snapped onto the road network.
    snapped_trace_points: ?[]const RoadSnapSnappedTracePoint = null,

    pub const json_field_names = .{
        .notices = "Notices",
        .pricing_bucket = "PricingBucket",
        .snapped_geometry = "SnappedGeometry",
        .snapped_geometry_format = "SnappedGeometryFormat",
        .snapped_trace_points = "SnappedTracePoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SnapToRoadsInput, options: CallOptions) !SnapToRoadsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "georoutes");

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

fn serializeRequest(allocator: std.mem.Allocator, input: SnapToRoadsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("georoutes", "Geo Routes", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/snap-to-roads";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.snapped_geometry_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnappedGeometryFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.snap_radius) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnapRadius\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TracePoints\":");
    try aws.json.writeValue(@TypeOf(input.trace_points), input.trace_points, allocator, &body_buf);
    has_prev = true;
    if (input.travel_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TravelMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.travel_mode_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TravelModeOptions\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SnapToRoadsOutput {
    var result: SnapToRoadsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SnapToRoadsOutput, body, allocator);
    }
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
