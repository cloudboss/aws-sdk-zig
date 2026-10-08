const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteSlackUserIdentityInput = struct {
    /// The ARN of the SlackChannelConfiguration associated with the user identity
    /// to delete.
    chat_configuration_arn: []const u8,

    /// The ID of the Slack workspace authorized with AWS Chatbot.
    slack_team_id: []const u8,

    /// The ID of the user in Slack
    slack_user_id: []const u8,

    pub const json_field_names = .{
        .chat_configuration_arn = "ChatConfigurationArn",
        .slack_team_id = "SlackTeamId",
        .slack_user_id = "SlackUserId",
    };
};

pub const DeleteSlackUserIdentityOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteSlackUserIdentityInput, options: CallOptions) !DeleteSlackUserIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteSlackUserIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-slack-user-identity";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChatConfigurationArn\":");
    try aws.json.writeValue(@TypeOf(input.chat_configuration_arn), input.chat_configuration_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SlackTeamId\":");
    try aws.json.writeValue(@TypeOf(input.slack_team_id), input.slack_team_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SlackUserId\":");
    try aws.json.writeValue(@TypeOf(input.slack_user_id), input.slack_user_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteSlackUserIdentityOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteSlackUserIdentityOutput = .{};

    return result;
}
