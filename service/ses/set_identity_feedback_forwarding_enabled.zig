const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SetIdentityFeedbackForwardingEnabledInput = struct {
    /// Sets whether Amazon SES forwards bounce and complaint notifications as
    /// email.
    /// `true` specifies that Amazon SES forwards bounce and complaint notifications
    /// as email, in addition to any Amazon SNS topic publishing otherwise
    /// specified.
    /// `false` specifies that Amazon SES publishes bounce and complaint
    /// notifications
    /// only through Amazon SNS. This value can only be set to `false` when Amazon
    /// SNS topics
    /// are set for both `Bounce` and `Complaint` notification
    /// types.
    forwarding_enabled: ?bool = null,

    /// The identity for which to set bounce and complaint notification forwarding.
    /// Examples:
    /// `user@example.com`, `example.com`.
    identity: []const u8,
};

pub const SetIdentityFeedbackForwardingEnabledOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetIdentityFeedbackForwardingEnabledInput, options: CallOptions) !SetIdentityFeedbackForwardingEnabledOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetIdentityFeedbackForwardingEnabledInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SES", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetIdentityFeedbackForwardingEnabled&Version=2010-12-01");
    try body_buf.appendSlice(allocator, "&ForwardingEnabled=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.forwarding_enabled) "true" else "false");
    try body_buf.appendSlice(allocator, "&Identity=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.identity);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetIdentityFeedbackForwardingEnabledOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: SetIdentityFeedbackForwardingEnabledOutput = .{};

    return result;
}
