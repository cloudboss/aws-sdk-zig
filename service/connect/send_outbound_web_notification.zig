const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WebNotificationContent = @import("web_notification_content.zig").WebNotificationContent;
const WidgetDestination = @import("widget_destination.zig").WidgetDestination;
const WebNotificationSource = @import("web_notification_source.zig").WebNotificationSource;

pub const SendOutboundWebNotificationInput = struct {
    /// A unique identifier for the customer's web browser instance to which the
    /// notification is being sent.
    browser_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The content of the web notification, including the notification type, the
    /// view to render, and any optional
    /// attributes used to populate it.
    content: WebNotificationContent,

    /// The destination for the web notification, specifying the communication
    /// widget that delivers the notification
    /// and the customer profile of the recipient.
    destination: WidgetDestination,

    /// The timestamp, in Unix epoch time format, at which the web notification
    /// expires. After this time, the
    /// notification is no longer delivered to the customer's browser.
    expires_at: i64,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A unique identifier for the customer's web session to which the notification
    /// is being sent.
    session_id: []const u8,

    /// The source of the web notification. A `SourceCampaign` object identifies the
    /// campaign and outbound
    /// request that triggered this notification.
    source: WebNotificationSource,

    pub const json_field_names = .{
        .browser_id = "BrowserId",
        .client_token = "ClientToken",
        .content = "Content",
        .destination = "Destination",
        .expires_at = "ExpiresAt",
        .instance_id = "InstanceId",
        .session_id = "SessionId",
        .source = "Source",
    };
};

pub const SendOutboundWebNotificationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendOutboundWebNotificationInput, options: CallOptions) !SendOutboundWebNotificationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendOutboundWebNotificationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/outbound-web-notification");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"BrowserId\":");
    try aws.json.writeValue(@TypeOf(input.browser_id), input.browser_id, allocator, &body_buf);
    has_prev = true;
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExpiresAt\":");
    try aws.json.writeValue(@TypeOf(input.expires_at), input.expires_at, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SessionId\":");
    try aws.json.writeValue(@TypeOf(input.session_id), input.session_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendOutboundWebNotificationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: SendOutboundWebNotificationOutput = .{};

    return result;
}
