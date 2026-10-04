const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MonitorLocalResource = @import("monitor_local_resource.zig").MonitorLocalResource;
const MonitorRemoteResource = @import("monitor_remote_resource.zig").MonitorRemoteResource;
const MonitorStatus = @import("monitor_status.zig").MonitorStatus;

pub const CreateMonitorInput = struct {
    /// A unique, case-sensitive string of up to 64 ASCII characters that you
    /// specify to make an idempotent API request. Don't reuse the same client token
    /// for other API requests.
    client_token: ?[]const u8 = null,

    /// The local resources to monitor. A local resource in a workload is the
    /// location of the host, or hosts, where the Network Flow Monitor agent is
    /// installed. For example, if a workload consists of an interaction between a
    /// web service and a backend database (for example, Amazon Dynamo DB), the
    /// subnet with the EC2 instance that hosts the web service, which also runs the
    /// agent, is the local resource.
    ///
    /// Be aware that all local resources must belong to the current Region.
    local_resources: []const MonitorLocalResource,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The remote resources to monitor. A remote resource is the other endpoint in
    /// the bi-directional flow of a workload, with a local resource. For example,
    /// Amazon Dynamo DB can be a remote resource.
    ///
    /// When you specify remote resources, be aware that specific combinations of
    /// resources are allowed and others are not, including the following
    /// constraints:
    ///
    /// * All remote resources that you specify must all belong to a single Region.
    /// * If you specify Amazon Web Services services as remote resources, any other
    ///   remote resources that you specify must be in the current Region.
    /// * When you specify a remote resource for another Region, you can only
    ///   specify the `Region` resource type. You cannot specify a subnet, VPC, or
    ///   Availability Zone in another Region.
    /// * If you leave the `RemoteResources` parameter empty, the monitor will
    ///   include all network flows that terminate in the current Region.
    remote_resources: ?[]const MonitorRemoteResource = null,

    /// The Amazon Resource Name (ARN) of the scope for the monitor.
    scope_arn: []const u8,

    /// The tags for a monitor. You can add a maximum of 200 tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .local_resources = "localResources",
        .monitor_name = "monitorName",
        .remote_resources = "remoteResources",
        .scope_arn = "scopeArn",
        .tags = "tags",
    };
};

pub const CreateMonitorOutput = struct {
    /// The date and time when the monitor was created.
    created_at: i64,

    /// The local resources to monitor. A local resource in a workload is the
    /// location of hosts where the Network Flow Monitor agent is installed.
    local_resources: ?[]const MonitorLocalResource = null,

    /// The last date and time that the monitor was modified.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMonitorInput, options: CallOptions) !CreateMonitorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkflowmonitor", "NetworkFlowMonitor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/monitors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"localResources\":");
    try aws.json.writeValue(@TypeOf(input.local_resources), input.local_resources, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"monitorName\":");
    try aws.json.writeValue(@TypeOf(input.monitor_name), input.monitor_name, allocator, &body_buf);
    has_prev = true;
    if (input.remote_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"remoteResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scopeArn\":");
    try aws.json.writeValue(@TypeOf(input.scope_arn), input.scope_arn, allocator, &body_buf);
    has_prev = true;
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
