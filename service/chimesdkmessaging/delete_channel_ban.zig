const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteChannelBanInput = struct {
    /// The ARN of the channel from which the `AppInstanceUser` was banned.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the
    /// API call.
    chime_bearer: []const u8,

    /// The ARN of the `AppInstanceUser` that you want to reinstate.
    member_arn: []const u8,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .member_arn = "MemberArn",
    };
};

pub const DeleteChannelBanOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteChannelBanInput, options: CallOptions) !DeleteChannelBanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteChannelBanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/bans/");
    try path_buf.appendSlice(allocator, input.member_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteChannelBanOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteChannelBanOutput = .{};

    return result;
}
