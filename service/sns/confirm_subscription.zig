const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ConfirmSubscriptionInput = struct {
    /// Disallows unauthenticated unsubscribes of the subscription. If the value of
    /// this
    /// parameter is `true` and the request has an Amazon Web Services signature,
    /// then only the
    /// topic owner and the subscription owner can unsubscribe the endpoint. The
    /// unsubscribe
    /// action requires Amazon Web Services authentication.
    authenticate_on_unsubscribe: ?[]const u8 = null,

    /// Short-lived token sent to an endpoint during the `Subscribe` action.
    token: []const u8,

    /// The ARN of the topic for which you wish to confirm a subscription.
    topic_arn: []const u8,
};

pub const ConfirmSubscriptionOutput = struct {
    /// The ARN of the created subscription.
    subscription_arn: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfirmSubscriptionInput, options: CallOptions) !ConfirmSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfirmSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sns", "SNS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ConfirmSubscription&Version=2010-03-31");
    if (input.authenticate_on_unsubscribe) |v| {
        try body_buf.appendSlice(allocator, "&AuthenticateOnUnsubscribe=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Token=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.token);
    try body_buf.appendSlice(allocator, "&TopicArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.topic_arn);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfirmSubscriptionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConfirmSubscriptionResult")) break;
            },
            else => {},
        }
    }

    var result: ConfirmSubscriptionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SubscriptionArn")) {
                    result.subscription_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
