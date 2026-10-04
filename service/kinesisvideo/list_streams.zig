const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamNameCondition = @import("stream_name_condition.zig").StreamNameCondition;
const StreamInfo = @import("stream_info.zig").StreamInfo;

pub const ListStreamsInput = struct {
    /// The maximum number of streams to return in the response. The default is
    /// 10,000.
    max_results: ?i32 = null,

    /// If you specify this parameter, when the result of a `ListStreams`
    /// operation is truncated, the call returns the `NextToken` in the response. To
    /// get another batch of streams, provide this token in your next request.
    next_token: ?[]const u8 = null,

    /// Optional: Returns only streams that satisfy a specific condition. Currently,
    /// you
    /// can specify only the prefix of a stream name as a condition.
    stream_name_condition: ?StreamNameCondition = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stream_name_condition = "StreamNameCondition",
    };
};

pub const ListStreamsOutput = struct {
    /// If the response is truncated, the call returns this element with a token. To
    /// get
    /// the next batch of streams, use this token in your next request.
    next_token: ?[]const u8 = null,

    /// An array of `StreamInfo` objects.
    stream_info_list: ?[]const StreamInfo = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .stream_info_list = "StreamInfoList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamsInput, options: CallOptions) !ListStreamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listStreams";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name_condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamNameCondition\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamsOutput {
    var result: ListStreamsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListStreamsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
