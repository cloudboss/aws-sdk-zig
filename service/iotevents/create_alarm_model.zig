const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlarmCapabilities = @import("alarm_capabilities.zig").AlarmCapabilities;
const AlarmEventActions = @import("alarm_event_actions.zig").AlarmEventActions;
const AlarmNotification = @import("alarm_notification.zig").AlarmNotification;
const AlarmRule = @import("alarm_rule.zig").AlarmRule;
const Tag = @import("tag.zig").Tag;
const AlarmModelVersionStatus = @import("alarm_model_version_status.zig").AlarmModelVersionStatus;

pub const CreateAlarmModelInput = struct {
    /// Contains the configuration information of alarm state changes.
    alarm_capabilities: ?AlarmCapabilities = null,

    /// Contains information about one or more alarm actions.
    alarm_event_actions: ?AlarmEventActions = null,

    /// A description that tells you what the alarm model detects.
    alarm_model_description: ?[]const u8 = null,

    /// A unique name that helps you identify the alarm model. You can't change this
    /// name after
    /// you create the alarm model.
    alarm_model_name: []const u8,

    /// Contains information about one or more notification actions.
    alarm_notification: ?AlarmNotification = null,

    /// Defines when your alarm is invoked.
    alarm_rule: AlarmRule,

    /// An input attribute used as a key to create an alarm.
    /// AWS IoT Events routes
    /// [inputs](https://docs.aws.amazon.com/iotevents/latest/apireference/API_Input.html)
    /// associated with this key to the alarm.
    key: ?[]const u8 = null,

    /// The ARN of the IAM role that allows the alarm to perform actions and access
    /// AWS resources. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    role_arn: []const u8,

    /// A non-negative integer that reflects the severity level of the alarm.
    severity: ?i32 = null,

    /// A list of key-value pairs that contain metadata for the alarm model. The
    /// tags help you
    /// manage the alarm model. For more information, see [Tagging your AWS IoT
    /// Events
    /// resources](https://docs.aws.amazon.com/iotevents/latest/developerguide/tagging-iotevents.html) in the *AWS IoT Events Developer Guide*.
    ///
    /// You can create up to 50 tags for one alarm model.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .alarm_capabilities = "alarmCapabilities",
        .alarm_event_actions = "alarmEventActions",
        .alarm_model_description = "alarmModelDescription",
        .alarm_model_name = "alarmModelName",
        .alarm_notification = "alarmNotification",
        .alarm_rule = "alarmRule",
        .key = "key",
        .role_arn = "roleArn",
        .severity = "severity",
        .tags = "tags",
    };
};

pub const CreateAlarmModelOutput = struct {
    /// The ARN of the alarm model. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    alarm_model_arn: ?[]const u8 = null,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    /// The time the alarm model was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    /// The time the alarm model was last updated, in the Unix epoch format.
    last_update_time: ?i64 = null,

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

    pub const json_field_names = .{
        .alarm_model_arn = "alarmModelArn",
        .alarm_model_version = "alarmModelVersion",
        .creation_time = "creationTime",
        .last_update_time = "lastUpdateTime",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAlarmModelInput, options: CallOptions) !CreateAlarmModelOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAlarmModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotevents", "IoT Events", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/alarm-models";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alarm_capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alarmCapabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.alarm_event_actions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alarmEventActions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.alarm_model_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alarmModelDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"alarmModelName\":");
    try aws.json.writeValue(@TypeOf(input.alarm_model_name), input.alarm_model_name, allocator, &body_buf);
    has_prev = true;
    if (input.alarm_notification) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alarmNotification\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"alarmRule\":");
    try aws.json.writeValue(@TypeOf(input.alarm_rule), input.alarm_rule, allocator, &body_buf);
    has_prev = true;
    if (input.key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"key\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.severity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"severity\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAlarmModelOutput {
    var result: CreateAlarmModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAlarmModelOutput, body, allocator);
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
