const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const LocationIdentifier = @import("location_identifier.zig").LocationIdentifier;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;
const InstrumentationConfigurationStatus = @import("instrumentation_configuration_status.zig").InstrumentationConfigurationStatus;
const InstrumentationStatusEvent = @import("instrumentation_status_event.zig").InstrumentationStatusEvent;
const Location = @import("location.zig").Location;

pub const GetInstrumentationConfigurationStatusInput = struct {
    /// The end of the time range to retrieve status events for. `StartTime` and
    /// `EndTime` must both be provided together or both be omitted. When both are
    /// omitted, the time range defaults to the last hour.
    end_time: ?i64 = null,

    /// Environment name for the instrumentation configuration.
    environment: []const u8,

    /// Type of instrumentation configuration (BREAKPOINT or PROBE).
    /// Required to identify the configuration to retrieve.
    instrumentation_type: InstrumentationType,

    /// Location identifier - either full code location or a pre-computed hash.
    location_identifier: LocationIdentifier,

    /// The maximum number of status events to return in one call. The default is
    /// 60.
    max_results: ?i32 = null,

    /// Use the token returned by a previous call to retrieve the next page of
    /// status events.
    next_token: ?[]const u8 = null,

    /// Service name for the instrumentation configuration.
    service: []const u8,

    /// Signal type for the instrumentation configuration.
    signal_type: DynamicInstrumentationSignalType,

    /// The start of the time range to retrieve status events for. `StartTime` and
    /// `EndTime` must both be provided together or both be omitted. When both are
    /// omitted, the time range defaults to the last hour.
    start_time: ?i64 = null,

    /// The single status to query for. If omitted, only `ACTIVE` status events are
    /// returned.
    status: ?InstrumentationConfigurationStatus = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .environment = "Environment",
        .instrumentation_type = "InstrumentationType",
        .location_identifier = "LocationIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service = "Service",
        .signal_type = "SignalType",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub const GetInstrumentationConfigurationStatusOutput = struct {
    /// The environment echoed from the request.
    environment: []const u8,

    /// The list of status events within the requested time window, sorted with the
    /// most recent first. Error events include an error cause.
    events: ?[]const InstrumentationStatusEvent = null,

    /// The code location echoed from the request.
    location: ?Location = null,

    /// Pagination token to continue retrieving status events.
    next_token: ?[]const u8 = null,

    /// The service name echoed from the request.
    service: []const u8,

    /// The telemetry signal type echoed from the request.
    signal_type: DynamicInstrumentationSignalType,

    /// The status that was queried. If not specified in the request, this is
    /// `ACTIVE`.
    status: InstrumentationConfigurationStatus,

    pub const json_field_names = .{
        .environment = "Environment",
        .events = "Events",
        .location = "Location",
        .next_token = "NextToken",
        .service = "Service",
        .signal_type = "SignalType",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstrumentationConfigurationStatusInput, options: CallOptions) !GetInstrumentationConfigurationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstrumentationConfigurationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-instrumentation-configuration-status";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EndTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstrumentationType\":");
    try aws.json.writeValue(@TypeOf(input.instrumentation_type), input.instrumentation_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LocationIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.location_identifier), input.location_identifier, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Service\":");
    try aws.json.writeValue(@TypeOf(input.service), input.service, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SignalType\":");
    try aws.json.writeValue(@TypeOf(input.signal_type), input.signal_type, allocator, &body_buf);
    has_prev = true;
    if (input.start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstrumentationConfigurationStatusOutput {
    const result: GetInstrumentationConfigurationStatusOutput = try aws.json.parseJsonObject(
        GetInstrumentationConfigurationStatusOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
