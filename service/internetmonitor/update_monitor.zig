const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HealthEventsConfig = @import("health_events_config.zig").HealthEventsConfig;
const InternetMeasurementsLogDelivery = @import("internet_measurements_log_delivery.zig").InternetMeasurementsLogDelivery;
const MonitorConfigState = @import("monitor_config_state.zig").MonitorConfigState;

pub const UpdateMonitorInput = struct {
    /// A unique, case-sensitive string of up to 64 ASCII characters that you
    /// specify to make an idempotent API request. You should not reuse the same
    /// client
    /// token for other API requests.
    client_token: ?[]const u8 = null,

    /// The list of health score thresholds. A threshold percentage for health
    /// scores, along with other configuration information,
    /// determines when Internet Monitor creates a health event when there's an
    /// internet issue that affects your application end users.
    ///
    /// For more information, see [
    /// Change health event
    /// thresholds](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-overview.html#IMUpdateThresholdFromOverview) in the Internet Monitor section of the *CloudWatch User Guide*.
    health_events_config: ?HealthEventsConfig = null,

    /// Publish internet measurements for Internet Monitor to another location, such
    /// as an Amazon S3 bucket. The measurements are also published to Amazon
    /// CloudWatch Logs.
    internet_measurements_log_delivery: ?InternetMeasurementsLogDelivery = null,

    /// The maximum number of city-networks to monitor for your application. A
    /// city-network is the location (city) where clients access your
    /// application resources from and the ASN or network provider, such as an
    /// internet service provider (ISP), that clients access the resources
    /// through. Setting this limit can help control billing costs.
    max_city_networks_to_monitor: ?i32 = null,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The resources to include in a monitor, which you provide as a set of Amazon
    /// Resource Names (ARNs). Resources can be VPCs, NLBs,
    /// Amazon CloudFront distributions, or Amazon WorkSpaces directories.
    ///
    /// You can add a combination of VPCs and CloudFront distributions, or you can
    /// add WorkSpaces directories, or you can add NLBs. You can't add
    /// NLBs or WorkSpaces directories together with any other resources.
    ///
    /// If you add only Amazon Virtual Private Clouds resources, at least one VPC
    /// must have an Internet Gateway attached to it, to make sure that it has
    /// internet
    /// connectivity.
    resources_to_add: ?[]const []const u8 = null,

    /// The resources to remove from a monitor, which you provide as a set of Amazon
    /// Resource Names (ARNs).
    resources_to_remove: ?[]const []const u8 = null,

    /// The status for a monitor. The accepted values for `Status` with the
    /// `UpdateMonitor` API call are the following: `ACTIVE` and
    /// `INACTIVE`. The following values are *not* accepted: `PENDING`, and `ERROR`.
    status: ?MonitorConfigState = null,

    /// The percentage of the internet-facing traffic for your application that you
    /// want to monitor with this monitor. If you set a city-networks
    /// maximum, that limit overrides the traffic percentage that you set.
    ///
    /// To learn more, see [Choosing an application traffic percentage to monitor
    /// ](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/IMTrafficPercentage.html) in the Amazon CloudWatch Internet Monitor section of the *CloudWatch User Guide*.
    traffic_percentage_to_monitor: ?i32 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .health_events_config = "HealthEventsConfig",
        .internet_measurements_log_delivery = "InternetMeasurementsLogDelivery",
        .max_city_networks_to_monitor = "MaxCityNetworksToMonitor",
        .monitor_name = "MonitorName",
        .resources_to_add = "ResourcesToAdd",
        .resources_to_remove = "ResourcesToRemove",
        .status = "Status",
        .traffic_percentage_to_monitor = "TrafficPercentageToMonitor",
    };
};

pub const UpdateMonitorOutput = struct {
    /// The Amazon Resource Name (ARN) of the monitor.
    monitor_arn: []const u8,

    /// The status of a monitor.
    status: MonitorConfigState,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMonitorInput, options: CallOptions) !UpdateMonitorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "internetmonitor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMonitorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v20210603/Monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.health_events_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HealthEventsConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.internet_measurements_log_delivery) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InternetMeasurementsLogDelivery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_city_networks_to_monitor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxCityNetworksToMonitor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourcesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resources_to_remove) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourcesToRemove\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.traffic_percentage_to_monitor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TrafficPercentageToMonitor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
