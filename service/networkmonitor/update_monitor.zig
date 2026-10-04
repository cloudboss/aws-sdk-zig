const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitorState = @import("monitor_state.zig").MonitorState;

pub const UpdateMonitorInput = struct {
    /// The aggregation time, in seconds, to change to. This must be either `30` or
    /// `60`.
    aggregation_period: i64,

    /// The name of the monitor to update.
    monitor_name: []const u8,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .monitor_name = "monitorName",
    };
};

pub const UpdateMonitorOutput = struct {
    /// The changed aggregation period.
    aggregation_period: ?i64 = null,

    /// The ARN of the monitor that was updated.
    monitor_arn: []const u8,

    /// The name of the monitor that was updated.
    monitor_name: []const u8,

    /// The state of the updated monitor.
    state: MonitorState,

    /// The list of key-value pairs associated with the monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .state = "state",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMonitorInput, options: CallOptions) !UpdateMonitorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationPeriod\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_period), input.aggregation_period, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMonitorOutput {
    var result: UpdateMonitorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateMonitorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
