const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DetailType = @import("detail_type.zig").DetailType;
const EventTypeSummary = @import("event_type_summary.zig").EventTypeSummary;
const NotificationRuleStatus = @import("notification_rule_status.zig").NotificationRuleStatus;
const TargetSummary = @import("target_summary.zig").TargetSummary;

pub const DescribeNotificationRuleInput = struct {
    /// The Amazon Resource Name (ARN) of the notification rule.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const DescribeNotificationRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of the notification rule.
    arn: []const u8,

    /// The name or email alias of the person who created the notification rule.
    created_by: ?[]const u8 = null,

    /// The date and time the notification rule was created, in timestamp format.
    created_timestamp: ?i64 = null,

    /// The level of detail included in the notifications for this resource. BASIC
    /// will include only the
    /// contents of the event as it would appear in Amazon CloudWatch. FULL will
    /// include any supplemental information
    /// provided by CodeStar Notifications and/or the service for the resource for
    /// which the notification is created.
    detail_type: ?DetailType = null,

    /// A list of the event types associated with the notification rule.
    event_types: ?[]const EventTypeSummary = null,

    /// The date and time the notification rule was most recently updated, in
    /// timestamp
    /// format.
    last_modified_timestamp: ?i64 = null,

    /// The name of the notification rule.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource associated with the
    /// notification
    /// rule.
    resource: ?[]const u8 = null,

    /// The status of the notification rule. Valid statuses are on (sending
    /// notifications) or off
    /// (not sending notifications).
    status: ?NotificationRuleStatus = null,

    /// The tags associated with the notification rule.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of the Amazon Q Developer in chat applications topics and Amazon Q
    /// Developer in chat applications clients associated with the notification
    /// rule.
    targets: ?[]const TargetSummary = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .created_timestamp = "CreatedTimestamp",
        .detail_type = "DetailType",
        .event_types = "EventTypes",
        .last_modified_timestamp = "LastModifiedTimestamp",
        .name = "Name",
        .resource = "Resource",
        .status = "Status",
        .tags = "Tags",
        .targets = "Targets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNotificationRuleInput, options: CallOptions) !DescribeNotificationRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codestar-notifications");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNotificationRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-notifications", "codestar notifications", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/describeNotificationRule";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNotificationRuleOutput {
    var result: DescribeNotificationRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeNotificationRuleOutput, body, allocator);
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
