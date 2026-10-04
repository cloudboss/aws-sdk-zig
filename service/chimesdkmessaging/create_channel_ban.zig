const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Identity = @import("identity.zig").Identity;

pub const CreateChannelBanInput = struct {
    /// The ARN of the ban request.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API
    /// call.
    chime_bearer: []const u8,

    /// The `AppInstanceUserArn` of the member being banned.
    member_arn: []const u8,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .member_arn = "MemberArn",
    };
};

pub const CreateChannelBanOutput = struct {
    /// The ARN of the response to the ban request.
    channel_arn: ?[]const u8 = null,

    /// The `ChannelArn` and `BannedIdentity` of the member in the ban
    /// response.
    member: ?Identity = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .member = "Member",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelBanInput, options: CallOptions) !CreateChannelBanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelBanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/bans");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MemberArn\":");
    try aws.json.writeValue(@TypeOf(input.member_arn), input.member_arn, allocator, &body_buf);
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
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelBanOutput {
    var result: CreateChannelBanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChannelBanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
