const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IsolineAllowOptions = @import("isoline_allow_options.zig").IsolineAllowOptions;
const IsolineAvoidanceOptions = @import("isoline_avoidance_options.zig").IsolineAvoidanceOptions;
const IsolineDestinationOptions = @import("isoline_destination_options.zig").IsolineDestinationOptions;
const GeometryFormat = @import("geometry_format.zig").GeometryFormat;
const IsolineGranularityOptions = @import("isoline_granularity_options.zig").IsolineGranularityOptions;
const IsolineOptimizationObjective = @import("isoline_optimization_objective.zig").IsolineOptimizationObjective;
const RoutingObjective = @import("routing_objective.zig").RoutingObjective;
const IsolineOriginOptions = @import("isoline_origin_options.zig").IsolineOriginOptions;
const IsolineThresholds = @import("isoline_thresholds.zig").IsolineThresholds;
const IsolineTrafficOptions = @import("isoline_traffic_options.zig").IsolineTrafficOptions;
const IsolineTravelMode = @import("isoline_travel_mode.zig").IsolineTravelMode;
const IsolineTravelModeOptions = @import("isoline_travel_mode_options.zig").IsolineTravelModeOptions;
const Isoline = @import("isoline.zig").Isoline;

pub const CalculateIsolinesInput = struct {
    /// Features that are allowed while calculating an isoline.
    allow: ?IsolineAllowOptions = null,

    /// Time of arrival at the destination.
    ///
    /// Time format: `YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    arrival_time: ?[]const u8 = null,

    /// Features that are avoided while calculating a route. Avoidance is on a
    /// best-case basis. If an avoidance can't be satisfied for a particular case,
    /// it violates the avoidance and the returned response produces a notice for
    /// the violation.
    avoid: ?IsolineAvoidanceOptions = null,

    /// Uses the current time as the time of departure.
    depart_now: ?bool = null,

    /// Time of departure from thr origin.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: ?[]const u8 = null,

    /// The final position for the route. In the World Geodetic System (WGS 84)
    /// format: `[longitude, latitude]`.
    destination: ?[]const f64 = null,

    /// Destination related options.
    destination_options: ?IsolineDestinationOptions = null,

    /// The format of the returned IsolineGeometry.
    ///
    /// Default Value:`FlexiblePolyline`
    isoline_geometry_format: ?GeometryFormat = null,

    /// Defines the granularity of the returned Isoline.
    isoline_granularity: ?IsolineGranularityOptions = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Specifies the optimization criteria for when calculating an isoline.
    /// AccurateCalculation generates an isoline of higher granularity that is more
    /// precise. FastCalculation generates an isoline faster by reducing the
    /// granularity, and in turn the quality of the isoline. BalancedCalculation
    /// generates an isoline by balancing between quality and performance.
    ///
    /// Default Value: `BalancedCalculation`
    optimize_isoline_for: ?IsolineOptimizationObjective = null,

    /// Specifies the optimization criteria for calculating a route.
    ///
    /// Default Value: `FastestRoute`
    optimize_routing_for: ?RoutingObjective = null,

    /// The start position for the route.
    origin: ?[]const f64 = null,

    /// Origin related options.
    origin_options: ?IsolineOriginOptions = null,

    /// Threshold to be used for the isoline calculation. Up to 3 thresholds per
    /// provided type can be requested.
    ///
    /// You incur a calculation charge for each threshold. Using a large amount of
    /// thresholds in a request can lead you to incur unexpected charges. See [
    /// Amazon Location's pricing
    /// page](https://docs.aws.amazon.com/location/latest/developerguide/routes-pricing.html`) for more information.
    thresholds: IsolineThresholds,

    /// Traffic related options.
    traffic: ?IsolineTrafficOptions = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// The mode `Scooter` also applies to motorcycles, set to `Scooter` when wanted
    /// to calculate options for motorcycles.
    ///
    /// Default Value: `Car`
    travel_mode: ?IsolineTravelMode = null,

    /// Travel mode related options for the provided travel mode.
    travel_mode_options: ?IsolineTravelModeOptions = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .arrival_time = "ArrivalTime",
        .avoid = "Avoid",
        .depart_now = "DepartNow",
        .departure_time = "DepartureTime",
        .destination = "Destination",
        .destination_options = "DestinationOptions",
        .isoline_geometry_format = "IsolineGeometryFormat",
        .isoline_granularity = "IsolineGranularity",
        .key = "Key",
        .optimize_isoline_for = "OptimizeIsolineFor",
        .optimize_routing_for = "OptimizeRoutingFor",
        .origin = "Origin",
        .origin_options = "OriginOptions",
        .thresholds = "Thresholds",
        .traffic = "Traffic",
        .travel_mode = "TravelMode",
        .travel_mode_options = "TravelModeOptions",
    };
};

pub const CalculateIsolinesOutput = struct {
    /// Time of arrival at the destination. This parameter is returned only if the
    /// Destination parameters was provided in the request.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    arrival_time: ?[]const u8 = null,

    /// Time of departure from thr origin.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: ?[]const u8 = null,

    /// The format of the returned IsolineGeometry.
    ///
    /// Default Value:`FlexiblePolyline`
    isoline_geometry_format: GeometryFormat,

    /// Calculated isolines and associated properties.
    isolines: ?[]const Isoline = null,

    /// The pricing bucket for which the query is charged at.
    pricing_bucket: []const u8,

    /// Snapped destination that was used for the Isoline calculation.
    snapped_destination: ?[]const f64 = null,

    /// Snapped origin that was used for the Isoline calculation.
    snapped_origin: ?[]const f64 = null,

    pub const json_field_names = .{
        .arrival_time = "ArrivalTime",
        .departure_time = "DepartureTime",
        .isoline_geometry_format = "IsolineGeometryFormat",
        .isolines = "Isolines",
        .pricing_bucket = "PricingBucket",
        .snapped_destination = "SnappedDestination",
        .snapped_origin = "SnappedOrigin",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateIsolinesInput, options: Options) !CalculateIsolinesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CalculateIsolinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("georoutes", "Geo Routes", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/isolines";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.allow) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Allow\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.arrival_time) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ArrivalTime\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.avoid) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Avoid\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.depart_now) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DepartNow\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.departure_time) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DepartureTime\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Destination\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.destination_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DestinationOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.isoline_geometry_format) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IsolineGeometryFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.isoline_granularity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IsolineGranularity\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.optimize_isoline_for) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OptimizeIsolineFor\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.optimize_routing_for) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OptimizeRoutingFor\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.origin) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Origin\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.origin_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OriginOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Thresholds\":");
    try aws.json.writeValue(@TypeOf(input.thresholds), input.thresholds, alloc, &body_buf);
    has_prev = true;
    if (input.traffic) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Traffic\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.travel_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TravelMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.travel_mode_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"TravelModeOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CalculateIsolinesOutput {
    var result: CalculateIsolinesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateIsolinesOutput, body, alloc);
    }
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
