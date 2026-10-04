const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Probe = @import("probe.zig").Probe;
const MonitorState = @import("monitor_state.zig").MonitorState;

pub const GetMonitorInput = struct {
    /// The name of the monitor that details are returned for.
    monitor_name: []const u8,

    pub const json_field_names = .{
        .monitor_name = "monitorName",
    };
};

pub const GetMonitorOutput = struct {
    /// The aggregation period for the specified monitor.
    aggregation_period: i64,

    /// The time and date when the monitor was created.
    created_at: i64,

    /// The time and date when the monitor was last modified.
    modified_at: i64,

    /// The ARN of the selected monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The details about each probe associated with that monitor.
    probes: ?[]const Probe = null,

    /// Lists the status of the `state` of each monitor.
    state: MonitorState,

    /// The list of key-value pairs assigned to the monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .probes = "probes",
        .state = "state",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMonitorInput, options: CallOptions) !GetMonitorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmonitor", "NetworkMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMonitorOutput {
    const result: GetMonitorOutput = try aws.json.parseJsonObject(
        GetMonitorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
