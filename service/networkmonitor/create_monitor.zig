const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateMonitorProbeInput = @import("create_monitor_probe_input.zig").CreateMonitorProbeInput;
const MonitorState = @import("monitor_state.zig").MonitorState;

pub const CreateMonitorInput = struct {
    /// The time, in seconds, that metrics are aggregated and sent to Amazon
    /// CloudWatch. Valid
    /// values are either `30` or `60`. `60` is the default if
    /// no period is chosen.
    aggregation_period: ?i64 = null,

    /// Unique, case-sensitive identifier to ensure the idempotency of the request.
    /// Only returned if a client token was provided in the request.
    client_token: ?[]const u8 = null,

    /// The name identifying the monitor. It can contain only letters, underscores
    /// (_), or dashes (-), and can be up to 200 characters.
    monitor_name: []const u8,

    /// Displays a list of all of the probes created for a monitor.
    probes: ?[]const CreateMonitorProbeInput = null,

    /// The list of key-value pairs created and assigned to the monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .client_token = "clientToken",
        .monitor_name = "monitorName",
        .probes = "probes",
        .tags = "tags",
    };
};

pub const CreateMonitorOutput = struct {
    /// The number of seconds that metrics are aggregated by and sent to Amazon
    /// CloudWatch.
    /// This will be either `30` or `60`.
    aggregation_period: ?i64 = null,

    /// The ARN of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The state of the monitor.
    state: MonitorState,

    /// The list of key-value pairs assigned to the monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .state = "state",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMonitorInput, options: CallOptions) !CreateMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmonitor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/monitors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aggregation_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregationPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"monitorName\":");
    try aws.json.writeValue(@TypeOf(input.monitor_name), input.monitor_name, allocator, &body_buf);
    has_prev = true;
    if (input.probes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"probes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMonitorOutput {
    const result: CreateMonitorOutput = try aws.json.parseJsonObject(
        CreateMonitorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
