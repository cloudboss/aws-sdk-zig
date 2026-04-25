const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
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
    /// Enables special road types or features that should be considered for routing
    /// even if they might be restricted by default for the selected travel mode.
    /// These include high-occupancy vehicle and toll lanes.
    allow: ?IsolineAllowOptions = null,

    /// Determine areas from which `Destination` can be reached by this time, taking
    /// into account predicted traffic conditions and working backward to account
    /// for congestion patterns. This attribute cannot be used together with
    /// `DepartureTime` or `DepartNow`. Specified as an ISO-8601 timestamp with
    /// timezone offset.
    ///
    /// Time format: `YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    arrival_time: ?[]const u8 = null,

    /// Specifies road types, features, or areas to avoid (if possible) when
    /// calculating reachable areas. These are treated as preferences rather than
    /// strict constraints—if a route cannot be calculated without using an avoided
    /// feature, that avoidance preference may be ignored.
    avoid: ?IsolineAvoidanceOptions = null,

    /// When true, uses the current time as the departure time and takes current
    /// traffic conditions into account. This attribute cannot be used together with
    /// `DepartureTime` or `ArrivalTime`.
    depart_now: ?bool = null,

    /// Determine areas that can be reached when departing at this time, taking into
    /// account predicted traffic conditions. This attribute cannot be used together
    /// with `ArrivalTime` or `DepartNow`. Specified as an ISO-8601 timestamp with
    /// timezone offset.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: ?[]const u8 = null,

    /// An optional destination point, specified as `[longitude, latitude]`
    /// coordinates. When provided, the service calculates areas from which this
    /// destination can be reached within the specified thresholds. This reverses
    /// the usual isoline calculation to show areas that could reach your location,
    /// rather than areas you could reach from your location. Either `Origin` or
    /// `Destination` must be provided.
    destination: ?[]const f64 = null,

    /// Options that control how the destination point is matched to the road
    /// network and how routes can approach it. These options help improve travel
    /// time accuracy by accounting for real-world access to the destination.
    destination_options: ?IsolineDestinationOptions = null,

    /// The format of the returned IsolineGeometry.
    ///
    /// Default value:`FlexiblePolyline`
    isoline_geometry_format: ?GeometryFormat = null,

    /// Controls the detail level of the generated isolines. Higher granularity
    /// produces smoother shapes but requires more processing time and results in
    /// larger responses.
    isoline_granularity: ?IsolineGranularityOptions = null,

    /// An Amazon Location Service API Key with access to this action. If omitted,
    /// the request must be signed using Signature Version 4.
    key: ?[]const u8 = null,

    /// Controls the trade-off between calculation speed and isoline precision.
    /// Choose ` FastCalculation` for quicker results with less detail,
    /// `AccurateCalculation` for more precise results, or `BalancedCalculation` for
    /// a middle ground.
    ///
    /// Default value: `BalancedCalculation`
    optimize_isoline_for: ?IsolineOptimizationObjective = null,

    /// Determines whether routes prioritize shortest travel time (`FastestRoute`)
    /// or shortest physical distance (`ShortestRoute`) when calculating reachable
    /// areas.
    ///
    /// Default value: `FastestRoute`
    optimize_routing_for: ?RoutingObjective = null,

    /// The starting point for isoline calculations, specified as `[longitude,
    /// latitude]` coordinates. For example, this could be a store location, service
    /// center, or any point from which you want to calculate reachable areas.
    /// Either `Origin` or `Destination` must be provided.
    origin: ?[]const f64 = null,

    /// Options that control how the origin point is matched to the road network and
    /// how routes can depart from it. These options help improve travel time
    /// accuracy by accounting for real-world access from the origin.
    origin_options: ?IsolineOriginOptions = null,

    /// The distance or time thresholds used to determine reachable areas. You can
    /// specify up to five thresholds (which all must be the same type) to calculate
    /// multiple isolines in a single request. For example, to determine the areas
    /// that are reachable within 10 and 20 minutes of the origin, specify time
    /// thresholds of 600 and 1200 seconds.
    ///
    /// You incur a calculation charge for each threshold. Using a large number of
    /// thresholds in a request can lead to unexpected charges. For more
    /// information, see [Routes
    /// pricing](https://docs.aws.amazon.com/location/latest/developerguide/routes-pricing.html) in the *Amazon Location Service Developer Guide*.
    thresholds: IsolineThresholds,

    /// Configures how real-time and historical traffic data affects isoline
    /// calculations. Traffic patterns can significantly impact reachable areas,
    /// especially during peak hours.
    traffic: ?IsolineTrafficOptions = null,

    /// The mode of transportation to use for calculations. This affects which road
    /// types or features can be used, estimated speed, and the traffic levels that
    /// are applied.
    ///
    /// * `Car`—Standard passenger vehicle routing using roads accessible to cars
    /// * `Pedestrian`—Walking routes using pedestrian paths, sidewalks, and
    ///   crossings
    /// * `Scooter`—Light two-wheeled vehicle routing using roads and paths
    ///   accessible to scooters
    /// * `Truck`—Commercial truck routing considering vehicle dimensions, weight
    ///   restrictions, and hazardous material regulations
    ///
    /// The mode `Scooter` also applies to motorcycles; set this to `Scooter` when
    /// calculating isolines for motorcycles.
    ///
    /// Default value: `Car`
    travel_mode: ?IsolineTravelMode = null,

    /// Additional attributes that refine how reachable areas are calculated based
    /// on specific vehicle characteristics. These options help produce more
    /// accurate results by accounting for real-world constraints and capabilities.
    ///
    /// For example:
    ///
    /// * For trucks (`Truck`), specify dimensions, weight limits, and hazardous
    ///   cargo restrictions to ensure isolines only include roads that can
    ///   physically and legally accommodate the vehicle
    /// * For cars (`Car`), set maximum speed capabilities or indicate
    ///   high-occupancy vehicle eligibility to better estimate reachable areas
    /// * For scooters (`Scooter`), specify engine type and speed limitations to
    ///   more accurately model their travel capabilities
    ///
    /// Without these options, calculations use default assumptions that may not
    /// match your specific use case.
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
    /// Time of arrival at the destination, used for traffic calculations. This
    /// attribute is returned only if the `Destination` and `ArrivalTime` attributes
    /// were provided in the request.
    ///
    /// Time format: `YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    arrival_time: ?[]const u8 = null,

    /// Time of departure from the origin, used for traffic calculations. This
    /// attribute is returned when `Origin` was provided in the request and either a
    /// specific departure time was requested (`DepartureTime`) or `DepartNow` was
    /// set to true.
    ///
    /// Time format: `YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: ?[]const u8 = null,

    /// The format of the returned geometries, matching the format specified in the
    /// request. Either ` FlexiblePolyline` for compact encoding or `Simple` for
    /// GeoJSON-compatible coordinates.
    ///
    /// Default value:`FlexiblePolyline`
    isoline_geometry_format: GeometryFormat,

    /// Reachable areas, or isolines, for each threshold specified in the request.
    isolines: ?[]const Isoline = null,

    /// The pricing bucket applied to this calculation. Different buckets apply
    /// based on the travel mode and thresholds used.
    pricing_bucket: []const u8,

    /// The actual point on the road network used for calculations, which may differ
    /// from the requested destination if `Destination` was not directly on a road.
    snapped_destination: ?[]const f64 = null,

    /// The actual point on the road network used for calculations, which may differ
    /// from the requested origin if `Origin` was not directly on a road.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CalculateIsolinesInput, options: CallOptions) !CalculateIsolinesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CalculateIsolinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-routes", "Geo Routes", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/isolines";

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
    if (input.isoline_geometry_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsolineGeometryFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.isoline_granularity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsolineGranularity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optimize_isoline_for) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OptimizeIsolineFor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.optimize_routing_for) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OptimizeRoutingFor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.origin) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Origin\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.origin_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OriginOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Thresholds\":");
    try aws.json.writeValue(@TypeOf(input.thresholds), input.thresholds, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CalculateIsolinesOutput {
    var result: CalculateIsolinesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CalculateIsolinesOutput, body, allocator);
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
