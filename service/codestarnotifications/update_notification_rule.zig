const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DetailType = @import("detail_type.zig").DetailType;
const NotificationRuleStatus = @import("notification_rule_status.zig").NotificationRuleStatus;
const Target = @import("target.zig").Target;

pub const UpdateNotificationRuleInput = struct {
    /// The Amazon Resource Name (ARN) of the notification rule.
    arn: []const u8,

    /// The level of detail to include in the notifications for this resource. BASIC
    /// will include only the
    /// contents of the event as it would appear in Amazon CloudWatch. FULL will
    /// include any supplemental information
    /// provided by CodeStar Notifications and/or the service for the resource for
    /// which the notification is created.
    detail_type: ?DetailType = null,

    /// A list of event types associated with this notification rule. For a complete
    /// list of event types and IDs, see
    /// [Notification
    /// concepts](https://docs.aws.amazon.com/codestar-notifications/latest/userguide/concepts.html#concepts-api)
    /// in the *Developer Tools Console User Guide*.
    event_type_ids: ?[]const []const u8 = null,

    /// The name of the notification rule.
    name: ?[]const u8 = null,

    /// The status of the notification rule. Valid statuses include enabled (sending
    /// notifications) or
    /// disabled (not sending notifications).
    status: ?NotificationRuleStatus = null,

    /// The address and type of the targets to receive notifications from this
    /// notification
    /// rule.
    targets: ?[]const Target = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .detail_type = "DetailType",
        .event_type_ids = "EventTypeIds",
        .name = "Name",
        .status = "Status",
        .targets = "Targets",
    };
};

pub const UpdateNotificationRuleOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotificationRuleInput, options: Options) !UpdateNotificationRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codestarnotifications");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateNotificationRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestarnotifications", "codestar notifications", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/updateNotificationRule";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, alloc, &body_buf);
    has_prev = true;
    if (input.detail_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DetailType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.event_type_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EventTypeIds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.targets) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Targets\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateNotificationRuleOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateNotificationRuleOutput = .{};

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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
