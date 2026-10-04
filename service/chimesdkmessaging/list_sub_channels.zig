const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubChannelSummary = @import("sub_channel_summary.zig").SubChannelSummary;

pub const ListSubChannelsInput = struct {
    /// The ARN of elastic channel.
    channel_arn: []const u8,

    /// The `AppInstanceUserArn` of the user making the API call.
    chime_bearer: []const u8,

    /// The maximum number of sub-channels that you want to return.
    max_results: ?i32 = null,

    /// The token passed by previous API calls until all requested sub-channels are
    /// returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSubChannelsOutput = struct {
    /// The ARN of elastic channel.
    channel_arn: ?[]const u8 = null,

    /// The token passed by previous API calls until all requested sub-channels are
    /// returned.
    next_token: ?[]const u8 = null,

    /// The information about each sub-channel.
    sub_channels: ?[]const SubChannelSummary = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .next_token = "NextToken",
        .sub_channels = "SubChannels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubChannelsInput, options: CallOptions) !ListSubChannelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSubChannelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/subchannels");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSubChannelsOutput {
    var result: ListSubChannelsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSubChannelsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
