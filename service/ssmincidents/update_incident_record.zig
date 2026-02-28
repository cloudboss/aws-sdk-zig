const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChatChannel = @import("chat_channel.zig").ChatChannel;
const NotificationTargetItem = @import("notification_target_item.zig").NotificationTargetItem;
const IncidentRecordStatus = @import("incident_record_status.zig").IncidentRecordStatus;

pub const UpdateIncidentRecordInput = struct {
    /// The Amazon Resource Name (ARN) of the incident record you are updating.
    arn: []const u8,

    /// The Chatbot chat channel where responders can collaborate.
    chat_channel: ?ChatChannel = null,

    /// A token that ensures that a client calls the operation only once with the
    /// specified
    /// details.
    client_token: ?[]const u8 = null,

    /// Defines the impact of the incident to customers and applications. If you
    /// provide an impact
    /// for an incident, it overwrites the impact provided by the response plan.
    ///
    /// **Supported impact codes**
    ///
    /// * `1` - Critical
    ///
    /// * `2` - High
    ///
    /// * `3` - Medium
    ///
    /// * `4` - Low
    ///
    /// * `5` - No Impact
    impact: ?i32 = null,

    /// The Amazon SNS targets that Incident Manager notifies when a client updates
    /// an
    /// incident.
    ///
    /// Using multiple SNS topics creates redundancy in the event that a Region is
    /// down during the
    /// incident.
    notification_targets: ?[]const NotificationTargetItem = null,

    /// The status of the incident. Possible statuses are `Open` or
    /// `Resolved`.
    status: ?IncidentRecordStatus = null,

    /// A longer description of what occurred during the incident.
    summary: ?[]const u8 = null,

    /// A brief description of the incident.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .chat_channel = "chatChannel",
        .client_token = "clientToken",
        .impact = "impact",
        .notification_targets = "notificationTargets",
        .status = "status",
        .summary = "summary",
        .title = "title",
    };
};

pub const UpdateIncidentRecordOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIncidentRecordInput, options: Options) !UpdateIncidentRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssmincidents");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateIncidentRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssmincidents", "SSM Incidents", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/updateIncidentRecord";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, alloc, &body_buf);
    has_prev = true;
    if (input.chat_channel) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"chatChannel\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.impact) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"impact\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.notification_targets) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"notificationTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.summary) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"summary\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"title\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateIncidentRecordOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateIncidentRecordOutput = .{};

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
