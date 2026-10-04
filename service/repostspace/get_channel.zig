const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelRole = @import("channel_role.zig").ChannelRole;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;

pub const GetChannelInput = struct {
    /// The unique ID of the private re:Post channel.
    channel_id: []const u8,

    /// The unique ID of the private re:Post.
    space_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .space_id = "spaceId",
    };
};

pub const GetChannelOutput = struct {
    /// A description for the channel. This is used only to help you identify this
    /// channel.
    channel_description: ?[]const u8 = null,

    /// The unique ID of the private re:Post channel.
    channel_id: []const u8,

    /// The name for the channel. This must be unique per private re:Post.
    channel_name: []const u8,

    /// The channel roles associated to the users and groups of the channel.
    channel_roles: ?[]const aws.map.MapEntry([]const ChannelRole) = null,

    /// The status pf the channel.
    channel_status: ChannelStatus,

    /// The date when the channel was created.
    create_date_time: i64,

    /// The date when the channel was deleted.
    delete_date_time: ?i64 = null,

    /// The unique ID of the private re:Post.
    space_id: []const u8,

    pub const json_field_names = .{
        .channel_description = "channelDescription",
        .channel_id = "channelId",
        .channel_name = "channelName",
        .channel_roles = "channelRoles",
        .channel_status = "channelStatus",
        .create_date_time = "createDateTime",
        .delete_date_time = "deleteDateTime",
        .space_id = "spaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChannelInput, options: CallOptions) !GetChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "repostspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("repostspace", "repostspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/spaces/");
    try path_buf.appendSlice(allocator, input.space_id);
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetChannelOutput {
    var result: GetChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetChannelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
