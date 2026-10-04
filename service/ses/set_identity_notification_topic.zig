const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationType = @import("notification_type.zig").NotificationType;

pub const SetIdentityNotificationTopicInput = struct {
    /// The identity (email address or domain) for the Amazon SNS topic.
    ///
    /// You can only specify a verified identity for this parameter.
    ///
    /// You can specify an identity by using its name or by using its Amazon
    /// Resource Name
    /// (ARN). The following examples are all valid identities:
    /// `sender@example.com`,
    /// `example.com`,
    /// `arn:aws:ses:us-east-1:123456789012:identity/example.com`.
    identity: []const u8,

    /// The type of notifications that are published to the specified Amazon SNS
    /// topic.
    notification_type: NotificationType,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic. If the parameter is
    /// omitted from
    /// the request or a null value is passed, `SnsTopic` is cleared and publishing
    /// is disabled.
    sns_topic: ?[]const u8 = null,
};

pub const SetIdentityNotificationTopicOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityNotificationTopicInput, options: CallOptions) !SetIdentityNotificationTopicOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityNotificationTopicInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIdentityNotificationTopic&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);
    try body_buf.appendSlice(allocator, "&NotificationType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.notification_type.wireName());
    if (input.sns_topic) |v| {
        try body_buf.appendSlice(allocator, "&SnsTopic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityNotificationTopicOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetIdentityNotificationTopicOutput = .{};

    return result;
}
