const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelPrivacy = @import("channel_privacy.zig").ChannelPrivacy;
const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

pub const ListChannelsInput = struct {
    /// The ARN of the `AppInstance`.
    app_instance_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The maximum number of channels that you want to return.
    max_results: ?i32 = null,

    /// The token passed by previous API calls until all requested channels are
    /// returned.
    next_token: ?[]const u8 = null,

    /// The privacy setting. `PUBLIC` retrieves all the public channels.
    /// `PRIVATE` retrieves private channels. Only an `AppInstanceAdmin`
    /// can retrieve private channels.
    privacy: ?ChannelPrivacy = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .chime_bearer = "ChimeBearer",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .privacy = "Privacy",
    };
};

pub const ListChannelsOutput = struct {
    /// The information about each channel.
    channels: ?[]const ChannelSummary = null,

    /// The token returned from previous API requests until the number of channels
    /// is
    /// reached.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channels = "Channels",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChannelsInput, options: CallOptions) !ListChannelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChannelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/channels";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "app-instance-arn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.app_instance_arn);
    query_has_prev = true;
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
    if (input.privacy) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "privacy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChannelsOutput {
    const result: ListChannelsOutput = try aws.json.parseJsonObject(
        ListChannelsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
