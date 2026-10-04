const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    /// Default value: `FlexiblePolyline`
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
    /// Default value: `Car`
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo-routes", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SnapToRoadsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-routes", "Geo Routes", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/snap-to-roads";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SnapToRoadsOutput {
    var result: SnapToRoadsOutput = try aws.json.parseJsonObject(
        SnapToRoadsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
