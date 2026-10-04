const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageTag = @import("message_tag.zig").MessageTag;
const EmailInsights = @import("email_insights.zig").EmailInsights;

pub const GetMessageInsightsInput = struct {
    /// A `MessageId` is a unique identifier for a message, and is
    /// returned when sending emails through Amazon SES.
    message_id: []const u8,

    pub const json_field_names = .{
        .message_id = "MessageId",
    };
};

pub const GetMessageInsightsOutput = struct {
    /// A list of tags, in the form of name/value pairs, that were applied to the
    /// email you sent, along with Amazon SES
    /// [Auto-Tags](https://docs.aws.amazon.com/ses/latest/dg/monitor-using-event-publishing.html).
    email_tags: ?[]const MessageTag = null,

    /// The from address used to send the message.
    from_email_address: ?[]const u8 = null,

    /// A set of insights associated with the message.
    insights: ?[]const EmailInsights = null,

    /// A unique identifier for the message.
    message_id: ?[]const u8 = null,

    /// The subject line of the message.
    subject: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_tags = "EmailTags",
        .from_email_address = "FromEmailAddress",
        .insights = "Insights",
        .message_id = "MessageId",
        .subject = "Subject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMessageInsightsInput, options: CallOptions) !GetMessageInsightsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMessageInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/email/insights/");
    try path_buf.appendSlice(allocator, input.message_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMessageInsightsOutput {
    var result: GetMessageInsightsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMessageInsightsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
