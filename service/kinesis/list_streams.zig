const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamSummary = @import("stream_summary.zig").StreamSummary;

pub const ListStreamsInput = struct {
    /// The name of the stream to start the list with.
    exclusive_start_stream_name: ?[]const u8 = null,

    /// The maximum number of streams to list. The default value is 100. If you
    /// specify a
    /// value greater than 100, at most 100 results are returned.
    limit: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .exclusive_start_stream_name = "ExclusiveStartStreamName",
        .limit = "Limit",
        .next_token = "NextToken",
    };
};

pub const ListStreamsOutput = struct {
    /// If set to `true`, there are more streams available to list.
    has_more_streams: bool,

    next_token: ?[]const u8 = null,

    /// The names of the streams that are associated with the Amazon Web Services
    /// account
    /// making the `ListStreams` request.
    stream_names: ?[]const []const u8 = null,

    stream_summaries: ?[]const StreamSummary = null,

    pub const json_field_names = .{
        .has_more_streams = "HasMoreStreams",
        .next_token = "NextToken",
        .stream_names = "StreamNames",
        .stream_summaries = "StreamSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamsInput, options: CallOptions) !ListStreamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.ListStreams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListStreamsOutput, body, allocator);
}
