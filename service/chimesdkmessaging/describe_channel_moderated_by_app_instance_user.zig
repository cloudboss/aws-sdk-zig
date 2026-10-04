const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelModeratedByAppInstanceUserSummary = @import("channel_moderated_by_app_instance_user_summary.zig").ChannelModeratedByAppInstanceUserSummary;

pub const DescribeChannelModeratedByAppInstanceUserInput = struct {
    /// The ARN of the user or bot in the moderated channel.
    app_instance_user_arn: []const u8,

    /// The ARN of the moderated channel.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
    };
};

pub const DescribeChannelModeratedByAppInstanceUserOutput = struct {
    /// The moderated channel.
    channel: ?ChannelModeratedByAppInstanceUserSummary = null,

    pub const json_field_names = .{
        .channel = "Channel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChannelModeratedByAppInstanceUserInput, options: CallOptions) !DescribeChannelModeratedByAppInstanceUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChannelModeratedByAppInstanceUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "scope=app-instance-user-moderated-channel");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "app-instance-user-arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app_instance_user_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChannelModeratedByAppInstanceUserOutput {
    const result: DescribeChannelModeratedByAppInstanceUserOutput = try aws.json.parseJsonObject(
        DescribeChannelModeratedByAppInstanceUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
