const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SlackUserIdentity = @import("slack_user_identity.zig").SlackUserIdentity;

pub const DescribeSlackUserIdentitiesInput = struct {
    /// The Amazon Resource Name (ARN) of the SlackChannelConfiguration associated
    /// with the user identities to describe.
    chat_configuration_arn: ?[]const u8 = null,

    /// The maximum number of results to include in the response. If more results
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional token returned from a prior request. Use this token for
    /// pagination of results from this action. If this parameter is specified, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .chat_configuration_arn = "ChatConfigurationArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeSlackUserIdentitiesOutput = struct {
    /// An optional token returned from a prior request. Use this token for
    /// pagination of results from this action. If this parameter is specified, the
    /// response includes only results beyond the token, up to the value specified
    /// by MaxResults.
    next_token: ?[]const u8 = null,

    /// A list of Slack User Identities.
    slack_user_identities: ?[]const SlackUserIdentity = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .slack_user_identities = "SlackUserIdentities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSlackUserIdentitiesInput, options: CallOptions) !DescribeSlackUserIdentitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSlackUserIdentitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-slack-user-identities";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.chat_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChatConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSlackUserIdentitiesOutput {
    var result: DescribeSlackUserIdentitiesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeSlackUserIdentitiesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
