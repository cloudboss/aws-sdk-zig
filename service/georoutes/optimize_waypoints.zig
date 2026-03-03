const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const WaypointOptimizationAvoidanceOptions = @import("waypoint_optimization_avoidance_options.zig").WaypointOptimizationAvoidanceOptions;
const WaypointOptimizationClusteringOptions = @import("waypoint_optimization_clustering_options.zig").WaypointOptimizationClusteringOptions;
const WaypointOptimizationDestinationOptions = @import("waypoint_optimization_destination_options.zig").WaypointOptimizationDestinationOptions;
const WaypointOptimizationDriverOptions = @import("waypoint_optimization_driver_options.zig").WaypointOptimizationDriverOptions;
const WaypointOptimizationExclusionOptions = @import("waypoint_optimization_exclusion_options.zig").WaypointOptimizationExclusionOptions;
const WaypointOptimizationSequencingObjective = @import("waypoint_optimization_sequencing_objective.zig").WaypointOptimizationSequencingObjective;
const WaypointOptimizationOriginOptions = @import("waypoint_optimization_origin_options.zig").WaypointOptimizationOriginOptions;
const WaypointOptimizationTrafficOptions = @import("waypoint_optimization_traffic_options.zig").WaypointOptimizationTrafficOptions;
const WaypointOptimizationTravelMode = @import("waypoint_optimization_travel_mode.zig").WaypointOptimizationTravelMode;
const WaypointOptimizationTravelModeOptions = @import("waypoint_optimization_travel_mode_options.zig").WaypointOptimizationTravelModeOptions;
const WaypointOptimizationWaypoint = @import("waypoint_optimization_waypoint.zig").WaypointOptimizationWaypoint;
const WaypointOptimizationConnection = @import("waypoint_optimization_connection.zig").WaypointOptimizationConnection;
const WaypointOptimizationImpedingWaypoint = @import("waypoint_optimization_impeding_waypoint.zig").WaypointOptimizationImpedingWaypoint;
const WaypointOptimizationOptimizedWaypoint = @import("waypoint_optimization_optimized_waypoint.zig").WaypointOptimizationOptimizedWaypoint;
const WaypointOptimizationTimeBreakdown = @import("waypoint_optimization_time_breakdown.zig").WaypointOptimizationTimeBreakdown;

pub const OptimizeWaypointsInput = struct {
    /// Features that are avoided. Avoidance is on a best-case basis. If an
    /// avoidance can't be satisfied for a particular case, this setting is ignored.
    avoid: ?WaypointOptimizationAvoidanceOptions = null,

    /// Clustering allows you to specify how nearby waypoints can be clustered to
    /// improve the optimized sequence.
    clustering: ?WaypointOptimizationClusteringOptions = null,

    /// Departure time from the waypoint.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: ?[]const u8 = null,

    /// The final position for the route in the World Geodetic System (WGS 84)
    /// format: `[longitude, latitude]`.
    destination: ?[]const f64 = null,

    /// Destination related options.
    destination_options: ?WaypointOptimizationDestinationOptions = null,

    /// Driver related options.
    driver: ?WaypointOptimizationDriverOptions = null,

    /// Features to be strictly excluded while calculating the route.
    exclude: ?WaypointOptimizationExclusionOptions = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// Specifies the optimization criteria for the calculated sequence.
    ///
    /// Default Value: `FastestRoute`.
    optimize_sequencing_for: ?WaypointOptimizationSequencingObjective = null,

    /// The start position for the route.
    origin: []const f64,

    /// Origin related options.
    origin_options: ?WaypointOptimizationOriginOptions = null,

    /// Traffic-related options.
    traffic: ?WaypointOptimizationTrafficOptions = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// Default Value: `Car`
    travel_mode: ?WaypointOptimizationTravelMode = null,

    /// Travel mode related options for the provided travel mode.
    travel_mode_options: ?WaypointOptimizationTravelModeOptions = null,

    /// List of waypoints between the `Origin` and `Destination`.
    waypoints: ?[]const WaypointOptimizationWaypoint = null,

    pub const json_field_names = .{
        .avoid = "Avoid",
        .clustering = "Clustering",
        .departure_time = "DepartureTime",
        .destination = "Destination",
        .destination_options = "DestinationOptions",
        .driver = "Driver",
        .exclude = "Exclude",
        .key = "Key",
        .optimize_sequencing_for = "OptimizeSequencingFor",
        .origin = "Origin",
        .origin_options = "OriginOptions",
        .traffic = "Traffic",
        .travel_mode = "TravelMode",
        .travel_mode_options = "TravelModeOptions",
        .waypoints = "Waypoints",
    };
};

pub const OptimizeWaypointsOutput = struct {
    /// Details about the connection from one waypoint to the next, within the
    /// optimized sequence.
    connections: ?[]const WaypointOptimizationConnection = null,

    /// Overall distance to travel the whole sequence.
    distance: ?i64 = null,

    /// Overall duration to travel the whole sequence.
    ///
    /// **Unit**: `seconds`
    duration: ?i64 = null,

    /// Returns waypoints that caused the optimization problem to fail, and the
    /// constraints that were unsatisfied leading to the failure.
    impeding_waypoints: ?[]const WaypointOptimizationImpedingWaypoint = null,

    /// Waypoints in the order of the optimized sequence.
    optimized_waypoints: ?[]const WaypointOptimizationOptimizedWaypoint = null,

    /// The pricing bucket for which the query is charged at.
    pricing_bucket: []const u8,

    /// Time breakdown for the sequence.
    time_breakdown: ?WaypointOptimizationTimeBreakdown = null,

    pub const json_field_names = .{
        .connections = "Connections",
        .distance = "Distance",
        .duration = "Duration",
        .impeding_waypoints = "ImpedingWaypoints",
        .optimized_waypoints = "OptimizedWaypoints",
        .pricing_bucket = "PricingBucket",
        .time_breakdown = "TimeBreakdown",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: OptimizeWaypointsInput, options: CallOptions) !OptimizeWaypointsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: OptimizeWaypointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("georoutes", "Geo Routes", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/optimize-waypoints";

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

    if (input.avoid) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Avoid\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.clustering) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Clustering\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.departure_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartureTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Destination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.driver) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Driver\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exclude) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Exclude\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optimize_sequencing_for) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OptimizeSequencingFor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Origin\":");
    try aws.json.writeValue(@TypeOf(input.origin), input.origin, allocator, &body_buf);
    has_prev = true;
    if (input.origin_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OriginOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.traffic) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Traffic\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.waypoints) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Waypoints\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !OptimizeWaypointsOutput {
    var result: OptimizeWaypointsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(OptimizeWaypointsOutput, body, allocator);
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
