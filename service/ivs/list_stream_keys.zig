const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamKeySummary = @import("stream_key_summary.zig").StreamKeySummary;

pub const ListStreamKeysInput = struct {
    /// Channel ARN used to filter the list.
    channel_arn: []const u8,

    /// Maximum number of streamKeys to return. Default: 1.
    max_results: ?i32 = null,

    /// The first stream key to retrieve. This is used for pagination; see the
    /// `nextToken` response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListStreamKeysOutput = struct {
    /// If there are more stream keys than `maxResults`, use `nextToken` in the
    /// request to get the next set.
    next_token: ?[]const u8 = null,

    /// List of stream keys.
    stream_keys: ?[]const StreamKeySummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .stream_keys = "streamKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamKeysInput, options: CallOptions) !ListStreamKeysOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamKeysInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListStreamKeys";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"channelArn\":");
    try aws.json.writeValue(@TypeOf(input.channel_arn), input.channel_arn, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamKeysOutput {
    const result: ListStreamKeysOutput = try aws.json.parseJsonObject(
        ListStreamKeysOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
