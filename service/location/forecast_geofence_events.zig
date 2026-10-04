const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ForecastGeofenceEventsDeviceState = @import("forecast_geofence_events_device_state.zig").ForecastGeofenceEventsDeviceState;
const DistanceUnit = @import("distance_unit.zig").DistanceUnit;
const SpeedUnit = @import("speed_unit.zig").SpeedUnit;
const ForecastedEvent = @import("forecasted_event.zig").ForecastedEvent;

pub const ForecastGeofenceEventsInput = struct {
    /// The name of the geofence collection.
    collection_name: []const u8,

    /// Represents the device's state, including its current position and speed.
    /// When speed is omitted, this API performs a *containment check*. The
    /// *containment check* operation returns `IDLE` events for geofences where the
    /// device is currently inside of, but no other events.
    device_state: ForecastGeofenceEventsDeviceState,

    /// The distance unit used for the `NearestDistance` property returned in a
    /// forecasted event. The measurement system must match for `DistanceUnit` and
    /// `SpeedUnit`; if `Kilometers` is specified for `DistanceUnit`, then
    /// `SpeedUnit` must be `KilometersPerHour`.
    ///
    /// Default Value: `Kilometers`
    distance_unit: ?DistanceUnit = null,

    /// An optional limit for the number of resources returned in a single call.
    ///
    /// Default value: `20`
    max_results: ?i32 = null,

    /// The pagination token specifying which page of results to return in the
    /// response. If no token is provided, the default page is the first page.
    ///
    /// Default value: `null`
    next_token: ?[]const u8 = null,

    /// The speed unit for the device captured by the device state. The measurement
    /// system must match for `DistanceUnit` and `SpeedUnit`; if `Kilometers` is
    /// specified for `DistanceUnit`, then `SpeedUnit` must be `KilometersPerHour`.
    ///
    /// Default Value: `KilometersPerHour`.
    speed_unit: ?SpeedUnit = null,

    /// The forward-looking time window for forecasting, specified in minutes. The
    /// API only returns events that are predicted to occur within this time
    /// horizon. When no value is specified, this API performs a *containment
    /// check*. The *containment check* operation returns `IDLE` events for
    /// geofences where the device is currently inside of, but no other events.
    time_horizon_minutes: ?f64 = null,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .device_state = "DeviceState",
        .distance_unit = "DistanceUnit",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .speed_unit = "SpeedUnit",
        .time_horizon_minutes = "TimeHorizonMinutes",
    };
};

pub const ForecastGeofenceEventsOutput = struct {
    /// The distance unit for the forecasted events.
    distance_unit: DistanceUnit,

    /// The list of forecasted events.
    forecasted_events: ?[]const ForecastedEvent = null,

    /// The pagination token specifying which page of results to return in the
    /// response. If no token is provided, the default page is the first page.
    next_token: ?[]const u8 = null,

    /// The speed unit for the forecasted events.
    speed_unit: SpeedUnit,

    pub const json_field_names = .{
        .distance_unit = "DistanceUnit",
        .forecasted_events = "ForecastedEvents",
        .next_token = "NextToken",
        .speed_unit = "SpeedUnit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ForecastGeofenceEventsInput, options: CallOptions) !ForecastGeofenceEventsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ForecastGeofenceEventsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    try path_buf.appendSlice(allocator, "/forecast-geofence-events");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceState\":");
    try aws.json.writeValue(@TypeOf(input.device_state), input.device_state, allocator, &body_buf);
    has_prev = true;
    if (input.distance_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DistanceUnit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.speed_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SpeedUnit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.time_horizon_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TimeHorizonMinutes\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ForecastGeofenceEventsOutput {
    var result: ForecastGeofenceEventsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ForecastGeofenceEventsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
