const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaResource = @import("media_resource.zig").MediaResource;
const SuccessfulMonitorDeployment = @import("successful_monitor_deployment.zig").SuccessfulMonitorDeployment;
const MonitorDeployment = @import("monitor_deployment.zig").MonitorDeployment;
const SignalMapStatus = @import("signal_map_status.zig").SignalMapStatus;

pub const StartDeleteMonitorDeploymentInput = struct {
    /// A signal map's identifier. Can be either be its id or current name.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const StartDeleteMonitorDeploymentOutput = struct {
    /// A signal map's ARN (Amazon Resource Name)
    arn: ?[]const u8 = null,

    cloud_watch_alarm_template_group_ids: ?[]const []const u8 = null,

    created_at: ?i64 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// A top-level supported AWS resource ARN to discovery a signal map from.
    discovery_entry_point_arn: ?[]const u8 = null,

    /// Error message associated with a failed creation or failed update attempt of
    /// a signal map.
    error_message: ?[]const u8 = null,

    event_bridge_rule_template_group_ids: ?[]const []const u8 = null,

    failed_media_resource_map: ?[]const aws.map.MapEntry(MediaResource) = null,

    /// A signal map's id.
    id: ?[]const u8 = null,

    last_discovered_at: ?i64 = null,

    last_successful_monitor_deployment: ?SuccessfulMonitorDeployment = null,

    media_resource_map: ?[]const aws.map.MapEntry(MediaResource) = null,

    modified_at: ?i64 = null,

    /// If true, there are pending monitor changes for this signal map that can be
    /// deployed.
    monitor_changes_pending_deployment: ?bool = null,

    monitor_deployment: ?MonitorDeployment = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: ?[]const u8 = null,

    status: ?SignalMapStatus = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .cloud_watch_alarm_template_group_ids = "CloudWatchAlarmTemplateGroupIds",
        .created_at = "CreatedAt",
        .description = "Description",
        .discovery_entry_point_arn = "DiscoveryEntryPointArn",
        .error_message = "ErrorMessage",
        .event_bridge_rule_template_group_ids = "EventBridgeRuleTemplateGroupIds",
        .failed_media_resource_map = "FailedMediaResourceMap",
        .id = "Id",
        .last_discovered_at = "LastDiscoveredAt",
        .last_successful_monitor_deployment = "LastSuccessfulMonitorDeployment",
        .media_resource_map = "MediaResourceMap",
        .modified_at = "ModifiedAt",
        .monitor_changes_pending_deployment = "MonitorChangesPendingDeployment",
        .monitor_deployment = "MonitorDeployment",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDeleteMonitorDeploymentInput, options: CallOptions) !StartDeleteMonitorDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDeleteMonitorDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/signal-maps/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/monitor-deployment");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDeleteMonitorDeploymentOutput {
    var result: StartDeleteMonitorDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartDeleteMonitorDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
