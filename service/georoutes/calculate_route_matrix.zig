const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RouteMatrixAllowOptions = @import("route_matrix_allow_options.zig").RouteMatrixAllowOptions;
const RouteMatrixAvoidanceOptions = @import("route_matrix_avoidance_options.zig").RouteMatrixAvoidanceOptions;
const RouteMatrixDestination = @import("route_matrix_destination.zig").RouteMatrixDestination;
const RouteMatrixExclusionOptions = @import("route_matrix_exclusion_options.zig").RouteMatrixExclusionOptions;
const RoutingObjective = @import("routing_objective.zig").RoutingObjective;
const RouteMatrixOrigin = @import("route_matrix_origin.zig").RouteMatrixOrigin;
const RouteMatrixBoundary = @import("route_matrix_boundary.zig").RouteMatrixBoundary;
const RouteMatrixTrafficOptions = @import("route_matrix_traffic_options.zig").RouteMatrixTrafficOptions;
const RouteMatrixTravelMode = @import("route_matrix_travel_mode.zig").RouteMatrixTravelMode;
const RouteMatrixTravelModeOptions = @import("route_matrix_travel_mode_options.zig").RouteMatrixTravelModeOptions;
const RouteMatrixEntry = @import("route_matrix_entry.zig").RouteMatrixEntry;

pub const CalculateRouteMatrixInput = struct {
    /// Features that are allowed while calculating a route.
    allow: ?RouteMatrixAllowOptions = null,

    /// Features that are avoided while calculating a route. Avoidance is on a
    /// best-case basis. If an avoidance can't be satisfied for a particular case,
    /// it violates the avoidance and the returned response produces a notice for
    /// the violation.
    avoid: ?RouteMatrixAvoidanceOptions = null,

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

    /// List of destinations for the route.
    ///
    /// Route calculations are billed for each origin and destination pair. If you
    /// use a large matrix of origins and destinations, your costs will increase
    /// accordingly. See [ Amazon Location's pricing
    /// page](https://docs.aws.amazon.com/location/latest/developerguide/routes-pricing.html`) for more information.
    destinations: []const RouteMatrixDestination,

    /// Features to be strictly excluded while calculating the route.
    exclude: ?RouteMatrixExclusionOptions = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Specifies the optimization criteria for calculating a route.
    ///
    /// Default Value: `FastestRoute`
    optimize_routing_for: ?RoutingObjective = null,

    /// The position in longitude and latitude for the origin.
    ///
    /// Route calculations are billed for each origin and destination pair. Using a
    /// large amount of Origins in a request can lead you to incur unexpected
    /// charges. See [ Amazon Location's pricing
    /// page](https://docs.aws.amazon.com/location/latest/developerguide/routes-pricing.html`) for more information.
    origins: []const RouteMatrixOrigin,

    /// Boundary within which the matrix is to be calculated. All data, origins and
    /// destinations outside the boundary are considered invalid.
    ///
    /// When request routing boundary was set as AutoCircle, the response routing
    /// boundary will return Circle derived from the AutoCircle settings.
    routing_boundary: RouteMatrixBoundary,

    /// Traffic related options.
    traffic: ?RouteMatrixTrafficOptions = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// Default Value: `Car`
    travel_mode: ?RouteMatrixTravelMode = null,

    /// Travel mode related options for the provided travel mode.
    travel_mode_options: ?RouteMatrixTravelModeOptions = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .avoid = "Avoid",
        .depart_now = "DepartNow",
        .departure_time = "DepartureTime",
        .destinations = "Destinations",
        .exclude = "Exclude",
        .key = "Key",
        .optimize_routing_for = "OptimizeRoutingFor",
        .origins = "Origins",
        .routing_boundary = "RoutingBoundary",
        .traffic = "Traffic",
        .travel_mode = "TravelMode",
        .travel_mode_options = "TravelModeOptions",
    };
};

pub const CalculateRouteMatrixOutput = struct {
    /// The count of error results in the route matrix. If this number is 0, all
    /// routes were calculated successfully.
    error_count: i32,

    /// The pricing bucket for which the query is charged at.
    pricing_bucket: []const u8,

    /// The calculated route matrix containing the results for all pairs of Origins
    /// to Destination positions. Each row corresponds to one entry in Origins. Each
    /// entry in the row corresponds to the route from that entry in Origins to an
    /// entry in Destination positions.
    route_matrix: ?[]const []const RouteMatrixEntry = null,

    /// Boundary within which the matrix is to be calculated. All data, origins and
    /// destinations outside the boundary are considered invalid.
    ///
    /// When request routing boundary was set as AutoCircle, the response routing
    /// boundary will return Circle derived from the AutoCircle settings.
    routing_boundary: ?RouteMatrixBoundary = null,

    pub const json_field_names = .{
        .error_count = "ErrorCount",
        .pricing_bucket = "PricingBucket",
        .route_matrix = "RouteMatrix",
        .routing_boundary = "RoutingBoundary",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateRouteMatrixInput, options: Options) !CalculateRouteMatrixOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CalculateRouteMatrixInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("georoutes", "Geo Routes", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/route-matrix";

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
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Destinations\":");
    try aws.json.writeValue(@TypeOf(input.destinations), input.destinations, alloc, &body_buf);
    has_prev = true;
    if (input.exclude) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Exclude\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.optimize_routing_for) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OptimizeRoutingFor\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Origins\":");
    try aws.json.writeValue(@TypeOf(input.origins), input.origins, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RoutingBoundary\":");
    try aws.json.writeValue(@TypeOf(input.routing_boundary), input.routing_boundary, alloc, &body_buf);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CalculateRouteMatrixOutput {
    var result: CalculateRouteMatrixOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateRouteMatrixOutput, body, alloc);
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
