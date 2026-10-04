const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelSubtypeConfig = @import("channel_subtype_config.zig").ChannelSubtypeConfig;

pub const UpdateCampaignChannelSubtypeConfigInput = struct {
    channel_subtype_config: ChannelSubtypeConfig,

    id: []const u8,

    pub const json_field_names = .{
        .channel_subtype_config = "channelSubtypeConfig",
        .id = "id",
    };
};

pub const UpdateCampaignChannelSubtypeConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCampaignChannelSubtypeConfigInput, options: CallOptions) !UpdateCampaignChannelSubtypeConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect-campaigns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCampaignChannelSubtypeConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect-campaigns", "ConnectCampaignsV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/campaigns/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/channel-subtype-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channelSubtypeConfig\":");
    try aws.json.writeValue(@TypeOf(input.channel_subtype_config), input.channel_subtype_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCampaignChannelSubtypeConfigOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateCampaignChannelSubtypeConfigOutput = .{};

    return result;
}
