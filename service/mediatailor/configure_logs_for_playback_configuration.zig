const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdsInteractionLog = @import("ads_interaction_log.zig").AdsInteractionLog;
const LoggingStrategy = @import("logging_strategy.zig").LoggingStrategy;
const ManifestServiceInteractionLog = @import("manifest_service_interaction_log.zig").ManifestServiceInteractionLog;

pub const ConfigureLogsForPlaybackConfigurationInput = struct {
    /// The event types that MediaTailor emits in logs for interactions with the
    /// ADS.
    ads_interaction_log: ?AdsInteractionLog = null,

    /// The method used for collecting logs from AWS Elemental MediaTailor. To
    /// configure MediaTailor to send logs directly to Amazon CloudWatch Logs,
    /// choose `LEGACY_CLOUDWATCH`. To configure MediaTailor to send logs to
    /// CloudWatch, which then vends the logs to your destination of choice, choose
    /// `VENDED_LOGS`. Supported destinations are CloudWatch Logs log group, Amazon
    /// S3 bucket, and Amazon Data Firehose stream.
    ///
    /// To use vended logs, you must configure the delivery destination in Amazon
    /// CloudWatch, as described in [Enable logging from AWS services, Logging that
    /// requires additional permissions
    /// [V2]](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html#AWS-vended-logs-permissions-V2).
    enabled_logging_strategies: ?[]const LoggingStrategy = null,

    /// The event types that MediaTailor emits in logs for interactions with the
    /// origin server.
    manifest_service_interaction_log: ?ManifestServiceInteractionLog = null,

    /// The percentage of session logs that MediaTailor sends to your CloudWatch
    /// Logs account. For example, if your playback configuration has 1000 sessions
    /// and percentEnabled is set to `60`, MediaTailor sends logs for 600 of the
    /// sessions to CloudWatch Logs. MediaTailor decides at random which of the
    /// playback configuration sessions to send logs for. If you want to view logs
    /// for a specific session, you can use the [debug log
    /// mode](https://docs.aws.amazon.com/mediatailor/latest/ug/debug-log-mode.html).
    ///
    /// Valid values: `0` - `100`
    percent_enabled: i32 = 0,

    /// The name of the playback configuration.
    playback_configuration_name: []const u8,

    pub const json_field_names = .{
        .ads_interaction_log = "AdsInteractionLog",
        .enabled_logging_strategies = "EnabledLoggingStrategies",
        .manifest_service_interaction_log = "ManifestServiceInteractionLog",
        .percent_enabled = "PercentEnabled",
        .playback_configuration_name = "PlaybackConfigurationName",
    };
};

pub const ConfigureLogsForPlaybackConfigurationOutput = struct {
    /// The event types that MediaTailor emits in logs for interactions with the
    /// ADS.
    ads_interaction_log: ?AdsInteractionLog = null,

    /// The method used for collecting logs from AWS Elemental MediaTailor.
    /// `LEGACY_CLOUDWATCH` indicates that MediaTailor is sending logs directly to
    /// Amazon CloudWatch Logs. `VENDED_LOGS` indicates that MediaTailor is sending
    /// logs to CloudWatch, which then vends the logs to your destination of choice.
    /// Supported destinations are CloudWatch Logs log group, Amazon S3 bucket, and
    /// Amazon Data Firehose stream.
    enabled_logging_strategies: ?[]const LoggingStrategy = null,

    /// The event types that MediaTailor emits in logs for interactions with the
    /// origin server.
    manifest_service_interaction_log: ?ManifestServiceInteractionLog = null,

    /// The percentage of session logs that MediaTailor sends to your Cloudwatch
    /// Logs account.
    percent_enabled: i32 = 0,

    /// The name of the playback configuration.
    playback_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ads_interaction_log = "AdsInteractionLog",
        .enabled_logging_strategies = "EnabledLoggingStrategies",
        .manifest_service_interaction_log = "ManifestServiceInteractionLog",
        .percent_enabled = "PercentEnabled",
        .playback_configuration_name = "PlaybackConfigurationName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfigureLogsForPlaybackConfigurationInput, options: Options) !ConfigureLogsForPlaybackConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediatailor");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ConfigureLogsForPlaybackConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediatailor", "MediaTailor", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configureLogs/playbackConfiguration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.ads_interaction_log) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdsInteractionLog\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enabled_logging_strategies) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EnabledLoggingStrategies\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.manifest_service_interaction_log) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ManifestServiceInteractionLog\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"PercentEnabled\":");
    try aws.json.writeValue(@TypeOf(input.percent_enabled), input.percent_enabled, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"PlaybackConfigurationName\":");
    try aws.json.writeValue(@TypeOf(input.playback_configuration_name), input.playback_configuration_name, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ConfigureLogsForPlaybackConfigurationOutput {
    var result: ConfigureLogsForPlaybackConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ConfigureLogsForPlaybackConfigurationOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
