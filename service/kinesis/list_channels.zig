const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamFilter = @import("stream_filter.zig").StreamFilter;
const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

pub const ListChannelsInput = struct {
    /// The maximum number of channels to return in a single call. The default value
    /// is 100. If you specify a value greater than 100, at most 100 results are
    /// returned.
    max_results: ?i32 = null,

    /// The pagination token returned by a previous call. Specify this token to
    /// retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// Filters the results to channels associated with the specified streams.
    stream_filter: ?[]const StreamFilter = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stream_filter = "StreamFilter",
    };
};

pub const ListChannelsOutput = struct {
    /// A list of channel summaries.
    channel_summaries: ?[]const ChannelSummary = null,

    /// The pagination token to use in a subsequent call to retrieve the next page
    /// of results. This value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_summaries = "ChannelSummaries",
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChannelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.ListChannels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChannelsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListChannelsOutput, body, allocator);
}
