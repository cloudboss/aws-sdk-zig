const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelBanSummary = @import("channel_ban_summary.zig").ChannelBanSummary;

pub const ListChannelBansInput = struct {
    /// The ARN of the channel.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The maximum number of bans that you want returned.
    max_results: ?i32 = null,

    /// The token passed by previous API calls until all requested bans are
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListChannelBansOutput = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8 = null,

    /// The information for each requested ban.
    channel_bans: ?[]const ChannelBanSummary = null,

    /// The token passed by previous API calls until all requested bans are
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .channel_bans = "ChannelBans",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChannelBansInput, options: CallOptions) !ListChannelBansOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChannelBansInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/bans");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "next-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChannelBansOutput {
    var result: ListChannelBansOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChannelBansOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
