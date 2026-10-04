const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurableNotificationPriority = @import("configurable_notification_priority.zig").ConfigurableNotificationPriority;

pub const CreateNotificationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The localized content of the notification. A map where keys are locale codes
    /// and values are the notification text in that locale. Content supports links.
    /// Maximum 250 characters per locale.
    content: []const aws.map.StringMapEntry,

    /// The timestamp when the notification should expire and no longer be displayed
    /// to users. If not specified, defaults to one week from creation.
    expires_at: ?i64 = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    predefined_notification_id: ?[]const u8 = null,

    /// The priority level of the notification. Valid values are HIGH and LOW. High
    /// priority notifications are displayed above low priority notifications.
    priority: ?ConfigurableNotificationPriority = null,

    /// A list of Amazon Resource Names (ARNs) identifying the recipients of the
    /// notification. Can include user ARNs or instance ARNs to target all users in
    /// an instance. Maximum of 200 recipients.
    recipients: []const []const u8,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "Tags": {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .content = "Content",
        .expires_at = "ExpiresAt",
        .instance_id = "InstanceId",
        .predefined_notification_id = "PredefinedNotificationId",
        .priority = "Priority",
        .recipients = "Recipients",
        .tags = "Tags",
    };
};

pub const CreateNotificationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created notification.
    notification_arn: []const u8,

    /// The unique identifier assigned to the created notification.
    notification_id: []const u8,

    pub const json_field_names = .{
        .notification_arn = "NotificationArn",
        .notification_id = "NotificationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotificationInput, options: CallOptions) !CreateNotificationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/notifications/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.expires_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExpiresAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.predefined_notification_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PredefinedNotificationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Recipients\":");
    try aws.json.writeValue(@TypeOf(input.recipients), input.recipients, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotificationOutput {
    var result: CreateNotificationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateNotificationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
