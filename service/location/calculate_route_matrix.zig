const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CalculateRouteCarModeOptions = @import("calculate_route_car_mode_options.zig").CalculateRouteCarModeOptions;
const DistanceUnit = @import("distance_unit.zig").DistanceUnit;
const TravelMode = @import("travel_mode.zig").TravelMode;
const CalculateRouteTruckModeOptions = @import("calculate_route_truck_mode_options.zig").CalculateRouteTruckModeOptions;
const RouteMatrixEntry = @import("route_matrix_entry.zig").RouteMatrixEntry;
const CalculateRouteMatrixSummary = @import("calculate_route_matrix_summary.zig").CalculateRouteMatrixSummary;

pub const CalculateRouteMatrixInput = struct {
    /// The name of the route calculator resource that you want to use to calculate
    /// the route matrix.
    calculator_name: []const u8,

    /// Specifies route preferences when traveling by `Car`, such as avoiding routes
    /// that use ferries or tolls.
    ///
    /// Requirements: `TravelMode` must be specified as `Car`.
    car_mode_options: ?CalculateRouteCarModeOptions = null,

    /// Sets the time of departure as the current time. Uses the current time to
    /// calculate the route matrix. You can't set both `DepartureTime` and
    /// `DepartNow`. If neither is set, the best time of day to travel with the best
    /// traffic conditions is used to calculate the route matrix.
    ///
    /// Default Value: `false`
    ///
    /// Valid Values: `false` | `true`
    depart_now: ?bool = null,

    /// The list of departure (origin) positions for the route matrix. An array of
    /// points, each of which is itself a 2-value array defined in [WGS
    /// 84](https://earth-info.nga.mil/GandG/wgs84/index.html) format: `[longitude,
    /// latitude]`. For example, `[-123.115, 49.285]`.
    ///
    /// Depending on the data provider selected in the route calculator resource
    /// there may be additional restrictions on the inputs you can choose. See [
    /// Position
    /// restrictions](https://docs.aws.amazon.com/location/previous/developerguide/calculate-route-matrix.html#matrix-routing-position-limits) in the *Amazon Location Service Developer Guide*.
    ///
    /// For route calculators that use Esri as the data provider, if you specify a
    /// departure that's not located on a road, Amazon Location [ moves the position
    /// to the nearest
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html). The snapped value is available in the result in `SnappedDeparturePositions`.
    ///
    /// Valid Values: `[-180 to 180,-90 to 90]`
    departure_positions: []const []const f64,

    /// Specifies the desired time of departure. Uses the given time to calculate
    /// the route matrix. You can't set both `DepartureTime` and `DepartNow`. If
    /// neither is set, the best time of day to travel with the best traffic
    /// conditions is used to calculate the route matrix.
    ///
    /// Setting a departure time in the past returns a `400 ValidationException`
    /// error.
    ///
    /// * In [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html)
    ///   format: `YYYY-MM-DDThh:mm:ss.sssZ`. For example,
    ///   `2020–07-2T12:15:20.000Z+01:00`
    departure_time: ?i64 = null,

    /// The list of destination positions for the route matrix. An array of points,
    /// each of which is itself a 2-value array defined in [WGS
    /// 84](https://earth-info.nga.mil/GandG/wgs84/index.html) format: `[longitude,
    /// latitude]`. For example, `[-122.339, 47.615]`
    ///
    /// Depending on the data provider selected in the route calculator resource
    /// there may be additional restrictions on the inputs you can choose. See [
    /// Position
    /// restrictions](https://docs.aws.amazon.com/location/previous/developerguide/calculate-route-matrix.html#matrix-routing-position-limits) in the *Amazon Location Service Developer Guide*.
    ///
    /// For route calculators that use Esri as the data provider, if you specify a
    /// destination that's not located on a road, Amazon Location [ moves the
    /// position to the nearest
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html). The snapped value is available in the result in `SnappedDestinationPositions`.
    ///
    /// Valid Values: `[-180 to 180,-90 to 90]`
    destination_positions: []const []const f64,

    /// Set the unit system to specify the distance.
    ///
    /// Default Value: `Kilometers`
    distance_unit: ?DistanceUnit = null,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// The `TravelMode` you specify also determines how you specify route
    /// preferences:
    ///
    /// * If traveling by `Car` use the `CarModeOptions` parameter.
    /// * If traveling by `Truck` use the `TruckModeOptions` parameter.
    ///
    /// `Bicycle` or `Motorcycle` are only valid when using `Grab` as a data
    /// provider, and only within Southeast Asia.
    ///
    /// `Truck` is not available for Grab.
    ///
    /// For more information about using Grab as a data provider, see
    /// [GrabMaps](https://docs.aws.amazon.com/location/previous/developerguide/grab.html) in the *Amazon Location Service Developer Guide*.
    ///
    /// Default Value: `Car`
    travel_mode: ?TravelMode = null,

    /// Specifies route preferences when traveling by `Truck`, such as avoiding
    /// routes that use ferries or tolls, and truck specifications to consider when
    /// choosing an optimal road.
    ///
    /// Requirements: `TravelMode` must be specified as `Truck`.
    truck_mode_options: ?CalculateRouteTruckModeOptions = null,

    pub const json_field_names = .{
        .calculator_name = "CalculatorName",
        .car_mode_options = "CarModeOptions",
        .depart_now = "DepartNow",
        .departure_positions = "DeparturePositions",
        .departure_time = "DepartureTime",
        .destination_positions = "DestinationPositions",
        .distance_unit = "DistanceUnit",
        .key = "Key",
        .travel_mode = "TravelMode",
        .truck_mode_options = "TruckModeOptions",
    };
};

pub const CalculateRouteMatrixOutput = struct {
    /// The calculated route matrix containing the results for all pairs of
    /// `DeparturePositions` to `DestinationPositions`. Each row corresponds to one
    /// entry in `DeparturePositions`. Each entry in the row corresponds to the
    /// route from that entry in `DeparturePositions` to an entry in
    /// `DestinationPositions`.
    route_matrix: ?[]const []const RouteMatrixEntry = null,

    /// For routes calculated using an Esri route calculator resource, departure
    /// positions are snapped to the closest road. For Esri route calculator
    /// resources, this returns the list of departure/origin positions used for
    /// calculation of the `RouteMatrix`.
    snapped_departure_positions: ?[]const []const f64 = null,

    /// The list of destination positions for the route matrix used for calculation
    /// of the `RouteMatrix`.
    snapped_destination_positions: ?[]const []const f64 = null,

    /// Contains information about the route matrix, `DataSource`, `DistanceUnit`,
    /// `RouteCount` and `ErrorCount`.
    summary: ?CalculateRouteMatrixSummary = null,

    pub const json_field_names = .{
        .route_matrix = "RouteMatrix",
        .snapped_departure_positions = "SnappedDeparturePositions",
        .snapped_destination_positions = "SnappedDestinationPositions",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateRouteMatrixInput, options: CallOptions) !CalculateRouteMatrixOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CalculateRouteMatrixInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/routes/v0/calculators/");
    try path_buf.appendSlice(allocator, input.calculator_name);
    try path_buf.appendSlice(allocator, "/calculate/route-matrix");
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
    try body_buf.appendSlice(allocator, "\"DeparturePositions\":");
    try aws.json.writeValue(@TypeOf(input.departure_positions), input.departure_positions, allocator, &body_buf);
    has_prev = true;
    if (input.departure_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DepartureTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationPositions\":");
    try aws.json.writeValue(@TypeOf(input.destination_positions), input.destination_positions, allocator, &body_buf);
    has_prev = true;
    if (input.distance_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DistanceUnit\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CalculateRouteMatrixOutput {
    var result: CalculateRouteMatrixOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateRouteMatrixOutput, body, allocator);
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
