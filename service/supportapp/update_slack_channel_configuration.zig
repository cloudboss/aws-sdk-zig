const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const NotificationSeverityLevel = @import("notification_severity_level.zig").NotificationSeverityLevel;

pub const UpdateSlackChannelConfigurationInput = struct {
    /// The channel ID in Slack. This ID identifies a channel within a Slack
    /// workspace.
    channel_id: []const u8,

    /// The Slack channel name that you want to update.
    channel_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that you want to
    /// use to perform operations on Amazon Web Services. For more information, see
    /// [Managing access to
    /// the Amazon Web Services Support
    /// App](https://docs.aws.amazon.com/awssupport/latest/user/support-app-permissions.html) in the *Amazon Web Services Support User Guide*.
    channel_role_arn: ?[]const u8 = null,

    /// Whether you want to get notified when a support case has a new
    /// correspondence.
    notify_on_add_correspondence_to_case: ?bool = null,

    /// The case severity for a support case that you want to receive notifications.
    ///
    /// If you specify `high` or `all`, at least one of the following
    /// parameters must be `true`:
    ///
    /// * `notifyOnAddCorrespondenceToCase`
    ///
    /// * `notifyOnCreateOrReopenCase`
    ///
    /// * `notifyOnResolveCase`
    ///
    /// If you specify `none`, any of the following parameters that you specify in
    /// your
    /// request must be `false`:
    ///
    /// * `notifyOnAddCorrespondenceToCase`
    ///
    /// * `notifyOnCreateOrReopenCase`
    ///
    /// * `notifyOnResolveCase`
    ///
    /// If you don't specify these parameters in your request, the Amazon Web
    /// Services Support App uses the current
    /// values by default.
    notify_on_case_severity: ?NotificationSeverityLevel = null,

    /// Whether you want to get notified when a support case is created or reopened.
    notify_on_create_or_reopen_case: ?bool = null,

    /// Whether you want to get notified when a support case is resolved.
    notify_on_resolve_case: ?bool = null,

    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`.
    team_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .channel_name = "channelName",
        .channel_role_arn = "channelRoleArn",
        .notify_on_add_correspondence_to_case = "notifyOnAddCorrespondenceToCase",
        .notify_on_case_severity = "notifyOnCaseSeverity",
        .notify_on_create_or_reopen_case = "notifyOnCreateOrReopenCase",
        .notify_on_resolve_case = "notifyOnResolveCase",
        .team_id = "teamId",
    };
};

pub const UpdateSlackChannelConfigurationOutput = struct {
    /// The channel ID in Slack. This ID identifies a channel within a Slack
    /// workspace.
    channel_id: ?[]const u8 = null,

    /// The name of the Slack channel that you configure for the Amazon Web Services
    /// Support App.
    channel_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that you want to
    /// use to perform operations on Amazon Web Services. For more information, see
    /// [Managing access to
    /// the Amazon Web Services Support
    /// App](https://docs.aws.amazon.com/awssupport/latest/user/support-app-permissions.html) in the *Amazon Web Services Support User Guide*.
    channel_role_arn: ?[]const u8 = null,

    /// Whether you want to get notified when a support case has a new
    /// correspondence.
    notify_on_add_correspondence_to_case: ?bool = null,

    /// The case severity for a support case that you want to receive notifications.
    notify_on_case_severity: ?NotificationSeverityLevel = null,

    /// Whether you want to get notified when a support case is created or reopened.
    notify_on_create_or_reopen_case: ?bool = null,

    /// Whether you want to get notified when a support case is resolved.
    notify_on_resolve_case: ?bool = null,

    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`.
    team_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .channel_name = "channelName",
        .channel_role_arn = "channelRoleArn",
        .notify_on_add_correspondence_to_case = "notifyOnAddCorrespondenceToCase",
        .notify_on_case_severity = "notifyOnCaseSeverity",
        .notify_on_create_or_reopen_case = "notifyOnCreateOrReopenCase",
        .notify_on_resolve_case = "notifyOnResolveCase",
        .team_id = "teamId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSlackChannelConfigurationInput, options: CallOptions) !UpdateSlackChannelConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "supportapp");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSlackChannelConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportapp", "Support App", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/control/update-slack-channel-configuration";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channelId\":");
    try aws.json.writeValue(@TypeOf(input.channel_id), input.channel_id, allocator, &body_buf);
    has_prev = true;
    if (input.channel_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"channelName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.channel_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"channelRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notify_on_add_correspondence_to_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyOnAddCorrespondenceToCase\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notify_on_case_severity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyOnCaseSeverity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notify_on_create_or_reopen_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyOnCreateOrReopenCase\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notify_on_resolve_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notifyOnResolveCase\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"teamId\":");
    try aws.json.writeValue(@TypeOf(input.team_id), input.team_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSlackChannelConfigurationOutput {
    var result: UpdateSlackChannelConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSlackChannelConfigurationOutput, body, allocator);
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
