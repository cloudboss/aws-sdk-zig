const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NotificationConfigurationStatus = @import("notification_configuration_status.zig").NotificationConfigurationStatus;
const NotificationConfigurationSubtype = @import("notification_configuration_subtype.zig").NotificationConfigurationSubtype;
const NotificationConfigurationStructure = @import("notification_configuration_structure.zig").NotificationConfigurationStructure;

pub const ListNotificationConfigurationsInput = struct {
    /// The Amazon Resource Name (ARN) of the Channel to match.
    channel_arn: ?[]const u8 = null,

    /// The matched event source.
    ///
    /// Must match one of the valid EventBridge sources. Only Amazon Web Services
    /// service sourced events are supported. For example, `aws.ec2` and
    /// `aws.cloudwatch`. For more information, see [Event delivery from Amazon Web
    /// Services
    /// services](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-service-event.html#eb-service-event-delivery-level) in the *Amazon EventBridge User Guide*.
    event_rule_source: ?[]const u8 = null,

    /// The maximum number of results to be returned in this call. Defaults to 20.
    max_results: ?i32 = null,

    /// The start token for paginated calls. Retrieved from the response of a
    /// previous `ListEventRules` call. Next token uses Base64 encoding.
    next_token: ?[]const u8 = null,

    /// The `NotificationConfiguration` status to match.
    ///
    /// * Values:
    ///
    /// * `ACTIVE`
    ///
    /// * All `EventRules` are `ACTIVE` and any call can be run.
    ///
    /// * `PARTIALLY_ACTIVE`
    ///
    /// * Some `EventRules` are `ACTIVE` and some are `INACTIVE`. Any call can be
    ///   run.
    /// * Any call can be run.
    ///
    /// * `INACTIVE`
    ///
    /// * All `EventRules` are `INACTIVE` and any call can be run.
    ///
    /// * `DELETING`
    ///
    /// * This `NotificationConfiguration` is being deleted.
    /// * Only `GET` and `LIST` calls can be run.
    status: ?NotificationConfigurationStatus = null,

    /// The subtype used to filter the notification configurations in the request.
    subtype: ?NotificationConfigurationSubtype = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .event_rule_source = "eventRuleSource",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
        .subtype = "subtype",
    };
};

pub const ListNotificationConfigurationsOutput = struct {
    /// A pagination token. If a non-null pagination token is returned in a result,
    /// pass its value in another request to retrieve more entries.
    next_token: ?[]const u8 = null,

    /// The `NotificationConfigurations` in the account.
    notification_configurations: ?[]const NotificationConfigurationStructure = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .notification_configurations = "notificationConfigurations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotificationConfigurationsInput, options: Options) !ListNotificationConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "notifications");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotificationConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/notification-configurations";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.channel_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "channelArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.event_rule_source) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "eventRuleSource=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.subtype) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "subtype=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotificationConfigurationsOutput {
    var result: ListNotificationConfigurationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNotificationConfigurationsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
