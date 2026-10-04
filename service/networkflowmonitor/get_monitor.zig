const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitorLocalResource = @import("monitor_local_resource.zig").MonitorLocalResource;
const MonitorStatus = @import("monitor_status.zig").MonitorStatus;
const MonitorRemoteResource = @import("monitor_remote_resource.zig").MonitorRemoteResource;

pub const GetMonitorInput = struct {
    /// The name of the monitor.
    monitor_name: []const u8,

    pub const json_field_names = .{
        .monitor_name = "monitorName",
    };
};

pub const GetMonitorOutput = struct {
    /// The date and time when the monitor was created.
    created_at: i64,

    /// The local resources to monitor. A local resource in a workload is the
    /// location of the hosts where the Network Flow Monitor agent is installed.
    local_resources: ?[]const MonitorLocalResource = null,

    /// The date and time when the monitor was last modified.
    modified_at: i64,

    /// The Amazon Resource Name (ARN) of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The status of a monitor. The status can be one of the following
    ///
    /// * `PENDING`: The monitor is in the process of being created.
    /// * `ACTIVE`: The monitor is active.
    /// * `INACTIVE`: The monitor is inactive.
    /// * `ERROR`: Monitor creation failed due to an error.
    /// * `DELETING`: The monitor is in the process of being deleted.
    monitor_status: MonitorStatus,

    /// The remote resources to monitor. A remote resource is the other endpoint
    /// specified for the network flow of a workload, with a local resource. For
    /// example, Amazon Dynamo DB can be a remote resource.
    remote_resources: ?[]const MonitorRemoteResource = null,

    /// The tags for a monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .local_resources = "localResources",
        .modified_at = "modifiedAt",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .monitor_status = "monitorStatus",
        .remote_resources = "remoteResources",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkflowmonitor", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

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
