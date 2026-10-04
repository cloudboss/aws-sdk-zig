const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProgressUpdateStreamSummary = @import("progress_update_stream_summary.zig").ProgressUpdateStreamSummary;

pub const ListProgressUpdateStreamsInput = struct {
    /// Filter to limit the maximum number of results to list per page.
    max_results: ?i32 = null,

    /// If a `NextToken` was returned by a previous call, there are more results
    /// available. To retrieve the next page of results, make the call again using
    /// the returned
    /// token in `NextToken`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListProgressUpdateStreamsOutput = struct {
    /// If there are more streams created than the max result, return the next token
    /// to be
    /// passed to the next call as a bookmark of where to start from.
    next_token: ?[]const u8 = null,

    /// List of progress update streams up to the max number of results passed in
    /// the
    /// input.
    progress_update_stream_summary_list: ?[]const ProgressUpdateStreamSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .progress_update_stream_summary_list = "ProgressUpdateStreamSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProgressUpdateStreamsInput, options: CallOptions) !ListProgressUpdateStreamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProgressUpdateStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.ListProgressUpdateStreams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProgressUpdateStreamsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListProgressUpdateStreamsOutput, body, allocator);
}
