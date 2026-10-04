const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamUrlStatus = @import("stream_url_status.zig").StreamUrlStatus;
const StreamUrlSummary = @import("stream_url_summary.zig").StreamUrlSummary;

pub const ListStreamUrlsInput = struct {
    /// The maximum number of results to return per page. Valid values are 1-100.
    /// The default is 25.
    max_results: ?i32 = null,

    /// The token that marks the start of the next set of results. Use this token
    /// when you retrieve results as sequential pages. To get the first page of
    /// results, omit a token value. To get the remaining pages, provide the token
    /// returned with the previous result set.
    next_token: ?[]const u8 = null,

    /// Filters the list to stream URLs with the specified status.
    ///
    /// * `ACTIVE`: The stream URL is valid and can start stream sessions.
    /// * `EXPIRED`: The stream URL has passed its expiration time and can no longer
    ///   start stream sessions.
    /// * `REVOKED`: The stream URL was revoked and can no longer start stream
    ///   sessions.
    /// * `LIMIT_REACHED`: The stream URL has been used the maximum number of times
    ///   and can no longer start stream sessions.
    status: ?StreamUrlStatus = null,

    /// Filters the list to stream URLs that belong to the specified stream group.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    stream_group_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
        .stream_group_identifier = "StreamGroupIdentifier",
    };
};

pub const ListStreamUrlsOutput = struct {
    /// A collection of stream URL summaries. Each summary includes the identity,
    /// status, and usage of the stream URL, but not its full configuration.
    items: ?[]const StreamUrlSummary = null,

    /// A token that marks the start of the next sequential page of results. If an
    /// operation doesn't return a token, you've reached the end of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamUrlsInput, options: CallOptions) !ListStreamUrlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamUrlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/streamurls";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.stream_group_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "StreamGroupIdentifier=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamUrlsOutput {
    const result: ListStreamUrlsOutput = try aws.json.parseJsonObject(
        ListStreamUrlsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
