const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RouteAllowOptions = @import("route_allow_options.zig").RouteAllowOptions;
const RouteAvoidanceOptions = @import("route_avoidance_options.zig").RouteAvoidanceOptions;
const RouteDestinationOptions = @import("route_destination_options.zig").RouteDestinationOptions;
const RouteDriverOptions = @import("route_driver_options.zig").RouteDriverOptions;
const RouteExclusionOptions = @import("route_exclusion_options.zig").RouteExclusionOptions;
const MeasurementSystem = @import("measurement_system.zig").MeasurementSystem;
const RouteLegAdditionalFeature = @import("route_leg_additional_feature.zig").RouteLegAdditionalFeature;
const GeometryFormat = @import("geometry_format.zig").GeometryFormat;
const RoutingObjective = @import("routing_objective.zig").RoutingObjective;
const RouteOriginOptions = @import("route_origin_options.zig").RouteOriginOptions;
const RouteSpanAdditionalFeature = @import("route_span_additional_feature.zig").RouteSpanAdditionalFeature;
const RouteTollOptions = @import("route_toll_options.zig").RouteTollOptions;
const RouteTrafficOptions = @import("route_traffic_options.zig").RouteTrafficOptions;
const RouteTravelMode = @import("route_travel_mode.zig").RouteTravelMode;
const RouteTravelModeOptions = @import("route_travel_mode_options.zig").RouteTravelModeOptions;
const RouteTravelStepType = @import("route_travel_step_type.zig").RouteTravelStepType;
const RouteWaypoint = @import("route_waypoint.zig").RouteWaypoint;
const RouteResponseNotice = @import("route_response_notice.zig").RouteResponseNotice;
const Route = @import("route.zig").Route;

pub const CalculateRoutesInput = struct {
    /// Features that are allowed while calculating a route. Not supported in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    allow: ?RouteAllowOptions = null,

    /// Time of arrival at the destination. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
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
    /// the violation. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `ControlledAccessHighways`, `Ferries`, and `TollRoads`
    avoid: ?RouteAvoidanceOptions = null,

    /// Uses the current time as the time of departure.
    depart_now: ?bool = null,

    /// Time of departure from the origin.
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
    destination: []const f64,

    /// Destination related options. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    destination_options: ?RouteDestinationOptions = null,

    /// Driver related options. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    driver: ?RouteDriverOptions = null,

    /// Features to be strictly excluded while calculating the route. Not supported
    /// in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    exclude: ?RouteExclusionOptions = null,

    /// Measurement system to be used for instructions within steps in the response.
    instructions_measurement_system: ?MeasurementSystem = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// List of languages for instructions within steps in the response. Not
    /// supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// Instructions in the requested language are returned only if they are
    /// available.
    languages: ?[]const []const u8 = null,

    /// A list of optional additional parameters such as timezone that can be
    /// requested for each result. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `PassThroughWaypoints`, `Summary`, and `TravelStepInstructions`
    ///
    /// * `Elevation`: Retrieves the elevation information for each location.
    /// * `Incidents`: Provides information on traffic incidents along the route.
    /// * `PassThroughWaypoints`: Indicates waypoints that are passed through
    ///   without stopping.
    /// * `Summary`: Returns a summary of the route, including distance and
    ///   duration.
    /// * `Tolls`: Supplies toll cost information along the route.
    /// * `TravelStepInstructions`: Provides step-by-step instructions for travel
    ///   along the route.
    /// * `TruckRoadTypes`: Returns information about road types suitable for
    ///   trucks.
    /// * `TypicalDuration`: Gives typical travel duration based on historical data.
    /// * `Zones`: Specifies the time zone information for each waypoint.
    leg_additional_features: ?[]const RouteLegAdditionalFeature = null,

    /// Specifies the format of the geometry returned for each leg of the route. You
    /// can choose between two different geometry encoding formats.
    ///
    /// `FlexiblePolyline`: A compact and precise encoding format for the leg
    /// geometry. For more information on the format, see the GitHub repository for
    /// [https://github.com/aws-geospatial/polyline](https://github.com/aws-geospatial/polyline).
    ///
    /// `Simple`: A less compact encoding, which is easier to decode but may be less
    /// precise and result in larger payloads.
    leg_geometry_format: ?GeometryFormat = null,

    /// Maximum number of alternative routes to be provided in the response, if
    /// available. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only up to 3 alternative routes.
    max_alternatives: ?i32 = null,

    /// Controls the trade-off between achieving the shortest travel time
    /// (`FastestRoute`) and achieving the shortest physical distance
    /// ((`ShortestRoute`) when calculating each route in the matrix.
    ///
    /// Default value: `FastestRoute`
    optimize_routing_for: ?RoutingObjective = null,

    /// The start position for the route in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    origin: []const f64,

    /// Specifies how the origin point should be matched to the road network and any
    /// routing constraints that apply when the traveler is departing the origin.
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    origin_options: ?RouteOriginOptions = null,

    /// A list of optional features such as `SpeedLimit` that can be requested for a
    /// Span. A span is a section of a Leg for which the requested features have the
    /// same values. Not supported in `ap-southeast-1` and `ap-southeast-5` regions
    /// for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    span_additional_features: ?[]const RouteSpanAdditionalFeature = null,

    /// Toll related options. Not supported in `ap-southeast-1` and `ap-southeast-5`
    /// regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    tolls: ?RouteTollOptions = null,

    /// Traffic related options. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    traffic: ?RouteTrafficOptions = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `Car`, `Pedestrian`, and `Scooter` values.
    ///
    /// Default value: `Car`
    travel_mode: ?RouteTravelMode = null,

    /// Travel mode related options for the provided travel mode. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `Car` and `Pedestrian` travel mode options.
    travel_mode_options: ?RouteTravelModeOptions = null,

    /// Type of step returned by the response. `Default` provides basic steps
    /// intended for web based applications. `TurnByTurn` provides detailed
    /// instructions with more granularity intended for a turn based navigation
    /// system. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions `Default` does not return any steps.
    travel_step_type: ?RouteTravelStepType = null,

    /// List of waypoints between the Origin and Destination. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions max length is `100`.
    ///
    /// Max length: `23`
    waypoints: ?[]const RouteWaypoint = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .arrival_time = "ArrivalTime",
        .avoid = "Avoid",
        .depart_now = "DepartNow",
        .departure_time = "DepartureTime",
        .destination = "Destination",
        .destination_options = "DestinationOptions",
        .driver = "Driver",
        .exclude = "Exclude",
        .instructions_measurement_system = "InstructionsMeasurementSystem",
        .key = "Key",
        .languages = "Languages",
        .leg_additional_features = "LegAdditionalFeatures",
        .leg_geometry_format = "LegGeometryFormat",
        .max_alternatives = "MaxAlternatives",
        .optimize_routing_for = "OptimizeRoutingFor",
        .origin = "Origin",
        .origin_options = "OriginOptions",
        .span_additional_features = "SpanAdditionalFeatures",
        .tolls = "Tolls",
        .traffic = "Traffic",
        .travel_mode = "TravelMode",
        .travel_mode_options = "TravelModeOptions",
        .travel_step_type = "TravelStepType",
        .waypoints = "Waypoints",
    };
};

pub const CalculateRoutesOutput = struct {
    /// Specifies the format of the geometry returned for each leg of the route.
    leg_geometry_format: GeometryFormat,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    notices: ?[]const RouteResponseNotice = null,

    /// The pricing bucket for which the query is charged at.
    pricing_bucket: []const u8,

    /// The path from the origin to the destination.
    routes: ?[]const Route = null,

    pub const json_field_names = .{
        .leg_geometry_format = "LegGeometryFormat",
        .notices = "Notices",
        .pricing_bucket = "PricingBucket",
        .routes = "Routes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateRoutesInput, options: CallOptions) !CalculateRoutesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo-routes");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CalculateRoutesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-routes", "Geo Routes", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/routes";

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

    if (input.allow) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Allow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.arrival_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ArrivalTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.avoid) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Avoid\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.depart_now) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartNow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.departure_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartureTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
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
    if (input.instructions_measurement_system) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InstructionsMeasurementSystem\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.languages) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Languages\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.leg_additional_features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LegAdditionalFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.leg_geometry_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LegGeometryFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_alternatives) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxAlternatives\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optimize_routing_for) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OptimizeRoutingFor\":");
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
    if (input.span_additional_features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpanAdditionalFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tolls) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tolls\":");
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
    if (input.travel_step_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TravelStepType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CalculateRoutesOutput {
    var result: CalculateRoutesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateRoutesOutput, body, allocator);
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
