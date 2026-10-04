const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const InstrumentationConfigurationWithoutServiceEnv = @import("instrumentation_configuration_without_service_env.zig").InstrumentationConfigurationWithoutServiceEnv;

pub const ListInstrumentationConfigurationsInput = struct {
    /// The environment that the service is running in.
    environment: []const u8,

    /// Type of instrumentation configuration (BREAKPOINT or PROBE).
    /// Required to determine which backing store to query.
    instrumentation_type: InstrumentationType,

    /// The maximum number of configurations to return in one call. The default is
    /// 50 and the maximum is 100.
    max_results: ?i32 = null,

    /// Use the token returned by a previous call to retrieve the next page of
    /// configurations.
    next_token: ?[]const u8 = null,

    /// The name of the service to retrieve instrumentation configurations for.
    service: []const u8,

    /// The timestamp from the last successful sync. When provided, the response
    /// returns `Changed` as `false` if nothing is new since this time, or returns
    /// the latest configurations when changes exist.
    synced_at: ?i64 = null,

    pub const json_field_names = .{
        .environment = "Environment",
        .instrumentation_type = "InstrumentationType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service = "Service",
        .synced_at = "SyncedAt",
    };
};

pub const ListInstrumentationConfigurationsOutput = struct {
    /// Indicates whether there are configuration changes since the provided
    /// `SyncedAt` timestamp.
    changed: bool,

    /// The environment associated with the returned configurations.
    environment: []const u8,

    /// The current set of active instrumentation configurations for the service and
    /// environment. Items omit service and environment because they are provided in
    /// the request.
    latest_configurations: ?[]const InstrumentationConfigurationWithoutServiceEnv = null,

    /// Pagination token to continue listing configurations when more results are
    /// available.
    next_token: ?[]const u8 = null,

    /// The service name associated with the returned configurations.
    service: []const u8,

    /// The server timestamp to supply on the next sync call.
    synced_at: i64,

    /// The suggested number of seconds to wait before the next sync request. This
    /// is at least 60 seconds to prevent excessive polling.
    sync_interval: i32,

    pub const json_field_names = .{
        .changed = "Changed",
        .environment = "Environment",
        .latest_configurations = "LatestConfigurations",
        .next_token = "NextToken",
        .service = "Service",
        .synced_at = "SyncedAt",
        .sync_interval = "SyncInterval",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInstrumentationConfigurationsInput, options: CallOptions) !ListInstrumentationConfigurationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInstrumentationConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-instrumentation-configurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Environment\":");
    try aws.json.writeValue(@TypeOf(input.environment), input.environment, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstrumentationType\":");
    try aws.json.writeValue(@TypeOf(input.instrumentation_type), input.instrumentation_type, allocator, &body_buf);
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
    if (input.synced_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SyncedAt\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInstrumentationConfigurationsOutput {
    const result: ListInstrumentationConfigurationsOutput = try aws.json.parseJsonObject(
        ListInstrumentationConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
