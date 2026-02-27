const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AlarmCapabilities = @import("alarm_capabilities.zig").AlarmCapabilities;
const AlarmEventActions = @import("alarm_event_actions.zig").AlarmEventActions;
const AlarmNotification = @import("alarm_notification.zig").AlarmNotification;
const AlarmRule = @import("alarm_rule.zig").AlarmRule;
const AlarmModelVersionStatus = @import("alarm_model_version_status.zig").AlarmModelVersionStatus;

pub const DescribeAlarmModelInput = struct {
    /// The name of the alarm model.
    alarm_model_name: []const u8,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_model_name = "alarmModelName",
        .alarm_model_version = "alarmModelVersion",
    };
};

pub const DescribeAlarmModelOutput = struct {
    /// Contains the configuration information of alarm state changes.
    alarm_capabilities: ?AlarmCapabilities = null,

    /// Contains information about one or more alarm actions.
    alarm_event_actions: ?AlarmEventActions = null,

    /// The ARN of the alarm model. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    alarm_model_arn: ?[]const u8 = null,

    /// The description of the alarm model.
    alarm_model_description: ?[]const u8 = null,

    /// The name of the alarm model.
    alarm_model_name: ?[]const u8 = null,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    /// Contains information about one or more notification actions.
    alarm_notification: ?AlarmNotification = null,

    /// Defines when your alarm is invoked.
    alarm_rule: ?AlarmRule = null,

    /// The time the alarm model was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    /// An input attribute used as a key to create an alarm.
    /// AWS IoT Events routes
    /// [inputs](https://docs.aws.amazon.com/iotevents/latest/apireference/API_Input.html)
    /// associated with this key to the alarm.
    key: ?[]const u8 = null,

    /// The time the alarm model was last updated, in the Unix epoch format.
    last_update_time: ?i64 = null,

    /// The ARN of the IAM role that allows the alarm to perform actions and access
    /// AWS resources. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    role_arn: ?[]const u8 = null,

    /// A non-negative integer that reflects the severity level of the alarm.
    severity: ?i32 = null,

    /// The status of the alarm model. The status can be one of the following
    /// values:
    ///
    /// * `ACTIVE` - The alarm model is active and it's ready to evaluate data.
    ///
    /// * `ACTIVATING` - AWS IoT Events is activating your alarm model.
    /// Activating an alarm model can take up to a few minutes.
    ///
    /// * `INACTIVE` - The alarm model is inactive, so it isn't ready to evaluate
    ///   data.
    /// Check your alarm model information and update the alarm model.
    ///
    /// * `FAILED` - You couldn't create or update the alarm model. Check your alarm
    ///   model information
    /// and try again.
    status: ?AlarmModelVersionStatus = null,

    /// Contains information about the status of the alarm model.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_capabilities = "alarmCapabilities",
        .alarm_event_actions = "alarmEventActions",
        .alarm_model_arn = "alarmModelArn",
        .alarm_model_description = "alarmModelDescription",
        .alarm_model_name = "alarmModelName",
        .alarm_model_version = "alarmModelVersion",
        .alarm_notification = "alarmNotification",
        .alarm_rule = "alarmRule",
        .creation_time = "creationTime",
        .key = "key",
        .last_update_time = "lastUpdateTime",
        .role_arn = "roleArn",
        .severity = "severity",
        .status = "status",
        .status_message = "statusMessage",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlarmModelInput, options: Options) !DescribeAlarmModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotevents");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeAlarmModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/alarm-models/");
    try path_buf.appendSlice(alloc, input.alarm_model_name);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.alarm_model_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "version=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeAlarmModelOutput {
    var result: DescribeAlarmModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAlarmModelOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
