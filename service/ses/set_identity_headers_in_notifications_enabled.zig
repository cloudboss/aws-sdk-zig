const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationType = @import("notification_type.zig").NotificationType;

pub const SetIdentityHeadersInNotificationsEnabledInput = struct {
    /// Sets whether Amazon SES includes the original email headers in Amazon SNS
    /// notifications of the
    /// specified notification type. A value of `true` specifies that Amazon SES
    /// includes
    /// headers in notifications, and a value of `false` specifies that Amazon SES
    /// does
    /// not include headers in notifications.
    ///
    /// This value can only be set when `NotificationType` is already set to use a
    /// particular Amazon SNS topic.
    enabled: ?bool = null,

    /// The identity for which to enable or disable headers in notifications.
    /// Examples:
    /// `user@example.com`, `example.com`.
    identity: []const u8,

    /// The notification type for which to enable or disable headers in
    /// notifications.
    notification_type: NotificationType,
};

pub const SetIdentityHeadersInNotificationsEnabledOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityHeadersInNotificationsEnabledInput, options: CallOptions) !SetIdentityHeadersInNotificationsEnabledOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityHeadersInNotificationsEnabledInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIdentityHeadersInNotificationsEnabled&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Enabled=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.enabled) "true" else "false");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);
    try body_buf.appendSlice(allocator, "&NotificationType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.notification_type.wireName());

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityHeadersInNotificationsEnabledOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetIdentityHeadersInNotificationsEnabledOutput = .{};

    return result;
}
