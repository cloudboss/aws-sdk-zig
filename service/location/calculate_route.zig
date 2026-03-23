const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CalculateRouteCarModeOptions = @import("calculate_route_car_mode_options.zig").CalculateRouteCarModeOptions;
const DistanceUnit = @import("distance_unit.zig").DistanceUnit;
const OptimizationMode = @import("optimization_mode.zig").OptimizationMode;
const TravelMode = @import("travel_mode.zig").TravelMode;
const CalculateRouteTruckModeOptions = @import("calculate_route_truck_mode_options.zig").CalculateRouteTruckModeOptions;
const Leg = @import("leg.zig").Leg;
const CalculateRouteSummary = @import("calculate_route_summary.zig").CalculateRouteSummary;

pub const CalculateRouteInput = struct {
    /// Specifies the desired time of arrival. Uses the given time to calculate the
    /// route. Otherwise, the best time of day to travel with the best traffic
    /// conditions is used to calculate the route.
    ///
    /// ArrivalTime is not supported Esri.
    arrival_time: ?i64 = null,

    /// The name of the route calculator resource that you want to use to calculate
    /// the route.
    calculator_name: []const u8,

    /// Specifies route preferences when traveling by `Car`, such as avoiding routes
    /// that use ferries or tolls.
    ///
    /// Requirements: `TravelMode` must be specified as `Car`.
    car_mode_options: ?CalculateRouteCarModeOptions = null,

    /// Sets the time of departure as the current time. Uses the current time to
    /// calculate a route. Otherwise, the best time of day to travel with the best
    /// traffic conditions is used to calculate the route.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    depart_now: ?bool = null,

    /// The start position for the route. Defined in [World Geodetic System (WGS
    /// 84)](https://earth-info.nga.mil/index.php?dir=wgs84&action=wgs84) format:
    /// `[longitude, latitude]`.
    ///
    /// * For example, `[-123.115, 49.285]`
    ///
    /// If you specify a departure that's not located on a road, Amazon Location
    /// [moves the position to the nearest
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html). If Esri is the provider for your route calculator, specifying a route that is longer than 400 km returns a `400 RoutesValidationException` error.
    ///
    /// Valid Values: `[-180 to 180,-90 to 90]`
    departure_position: []const f64,

    /// Specifies the desired time of departure. Uses the given time to calculate
    /// the route. Otherwise, the best time of day to travel with the best traffic
    /// conditions is used to calculate the route.
    ///
    /// * In [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html)
    ///   format: `YYYY-MM-DDThh:mm:ss.sssZ`. For example,
    ///   `2020–07-2T12:15:20.000Z+01:00`
    departure_time: ?i64 = null,

    /// The finish position for the route. Defined in [World Geodetic System (WGS
    /// 84)](https://earth-info.nga.mil/index.php?dir=wgs84&action=wgs84) format:
    /// `[longitude, latitude]`.
    ///
    /// * For example, `[-122.339, 47.615]`
    ///
    /// If you specify a destination that's not located on a road, Amazon Location
    /// [moves the position to the nearest
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html).
    ///
    /// Valid Values: `[-180 to 180,-90 to 90]`
    destination_position: []const f64,

    /// Set the unit system to specify the distance.
    ///
    /// Default Value: `Kilometers`
    distance_unit: ?DistanceUnit = null,

    /// Set to include the geometry details in the result for each path between a
    /// pair of positions.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    include_leg_geometry: ?bool = null,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// Specifies the distance to optimize for when calculating a route.
    optimize_for: ?OptimizationMode = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility. You can choose `Car`, `Truck`,
    /// `Walking`, `Bicycle` or `Motorcycle` as options for the `TravelMode`.
    ///
    /// `Bicycle` and `Motorcycle` are only valid when using Grab as a data
    /// provider, and only within Southeast Asia.
    ///
    /// `Truck` is not available for Grab.
    ///
    /// For more details on the using Grab for routing, including areas of coverage,
    /// see
    /// [GrabMaps](https://docs.aws.amazon.com/location/previous/developerguide/grab.html) in the *Amazon Location Service Developer Guide*.
    ///
    /// The `TravelMode` you specify also determines how you specify route
    /// preferences:
    ///
    /// * If traveling by `Car` use the `CarModeOptions` parameter.
    /// * If traveling by `Truck` use the `TruckModeOptions` parameter.
    ///
    /// Default Value: `Car`
    travel_mode: ?TravelMode = null,

    /// Specifies route preferences when traveling by `Truck`, such as avoiding
    /// routes that use ferries or tolls, and truck specifications to consider when
    /// choosing an optimal road.
    ///
    /// Requirements: `TravelMode` must be specified as `Truck`.
    truck_mode_options: ?CalculateRouteTruckModeOptions = null,

    /// Specifies an ordered list of up to 23 intermediate positions to include
    /// along a route between the departure position and destination position.
    ///
    /// * For example, from the `DeparturePosition` `[-123.115, 49.285]`, the route
    ///   follows the order that the waypoint positions are given `[[-122.757,
    ///   49.0021],[-122.349, 47.620]]`
    ///
    /// If you specify a waypoint position that's not located on a road, Amazon
    /// Location [moves the position to the nearest
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html).
    ///
    /// Specifying more than 23 waypoints returns a `400 ValidationException` error.
    ///
    /// If Esri is the provider for your route calculator, specifying a route that
    /// is longer than 400 km returns a `400 RoutesValidationException` error.
    ///
    /// Valid Values: `[-180 to 180,-90 to 90]`
    waypoint_positions: ?[]const []const f64 = null,

    pub const json_field_names = .{
        .arrival_time = "ArrivalTime",
        .calculator_name = "CalculatorName",
        .car_mode_options = "CarModeOptions",
        .depart_now = "DepartNow",
        .departure_position = "DeparturePosition",
        .departure_time = "DepartureTime",
        .destination_position = "DestinationPosition",
        .distance_unit = "DistanceUnit",
        .include_leg_geometry = "IncludeLegGeometry",
        .key = "Key",
        .optimize_for = "OptimizeFor",
        .travel_mode = "TravelMode",
        .truck_mode_options = "TruckModeOptions",
        .waypoint_positions = "WaypointPositions",
    };
};

pub const CalculateRouteOutput = struct {
    /// Contains details about each path between a pair of positions included along
    /// a route such as: `StartPosition`, `EndPosition`, `Distance`,
    /// `DurationSeconds`, `Geometry`, and `Steps`. The number of legs returned
    /// corresponds to one fewer than the total number of positions in the request.
    ///
    /// For example, a route with a departure position and destination position
    /// returns one leg with the positions [snapped to a nearby
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html):
    ///
    /// * The `StartPosition` is the departure position.
    /// * The `EndPosition` is the destination position.
    ///
    /// A route with a waypoint between the departure and destination position
    /// returns two legs with the positions snapped to a nearby road:
    ///
    /// * Leg 1: The `StartPosition` is the departure position . The `EndPosition`
    ///   is the waypoint positon.
    /// * Leg 2: The `StartPosition` is the waypoint position. The `EndPosition` is
    ///   the destination position.
    legs: ?[]const Leg = null,

    /// Contains information about the whole route, such as: `RouteBBox`,
    /// `DataSource`, `Distance`, `DistanceUnit`, and `DurationSeconds`.
    summary: ?CalculateRouteSummary = null,

    pub const json_field_names = .{
        .legs = "Legs",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateRouteInput, options: CallOptions) !CalculateRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CalculateRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/routes/v0/calculators/");
    try path_buf.appendSlice(allocator, input.calculator_name);
    try path_buf.appendSlice(allocator, "/calculate/route");
    const path = try path_buf.toOwnedSlice(allocator);

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

    if (input.arrival_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ArrivalTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.car_mode_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CarModeOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.depart_now) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartNow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeparturePosition\":");
    try aws.json.writeValue(@TypeOf(input.departure_position), input.departure_position, allocator, &body_buf);
    has_prev = true;
    if (input.departure_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartureTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationPosition\":");
    try aws.json.writeValue(@TypeOf(input.destination_position), input.destination_position, allocator, &body_buf);
    has_prev = true;
    if (input.distance_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DistanceUnit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_leg_geometry) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeLegGeometry\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optimize_for) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OptimizeFor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.travel_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TravelMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.truck_mode_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TruckModeOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.waypoint_positions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"WaypointPositions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CalculateRouteOutput {
    var result: CalculateRouteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateRouteOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
