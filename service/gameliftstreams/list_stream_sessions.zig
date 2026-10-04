const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFilesStatus = @import("export_files_status.zig").ExportFilesStatus;
const StreamSessionStatus = @import("stream_session_status.zig").StreamSessionStatus;
const StreamSessionSummary = @import("stream_session_summary.zig").StreamSessionSummary;

pub const ListStreamSessionsInput = struct {
    /// Filter by the exported files status. You can specify one status in each
    /// request to retrieve only sessions that currently have that exported files
    /// status.
    ///
    /// Exported files can be in one of the following states:
    ///
    /// * `SUCCEEDED`: The exported files are successfully stored in an S3 bucket.
    /// * `FAILED`: The session ended but Amazon GameLift Streams couldn't collect
    ///   and upload the files to S3.
    /// * `PENDING`: Either the stream session is still in progress, or uploading
    ///   the exported files to the S3 bucket is in progress.
    export_files_status: ?ExportFilesStatus = null,

    /// The unique identifier of a Amazon GameLift Streams stream group to retrieve
    /// the stream session for. You can use either the stream group ID or the
    /// [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html).
    identifier: []const u8,

    /// The number of results to return. Use this parameter with `NextToken` to
    /// return results in sequential pages. Default value is `25`.
    max_results: ?i32 = null,

    /// The token that marks the start of the next set of results. Use this token
    /// when you retrieve results as sequential pages. To get the first page of
    /// results, omit a token value. To get the remaining pages, provide the token
    /// returned with the previous result set.
    next_token: ?[]const u8 = null,

    /// Filter by the stream session status. You can specify one status in each
    /// request to retrieve only sessions that are currently in that status.
    status: ?StreamSessionStatus = null,

    pub const json_field_names = .{
        .export_files_status = "ExportFilesStatus",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListStreamSessionsOutput = struct {
    /// A collection of Amazon GameLift Streams stream sessions that are associated
    /// with a stream group and returned in response to a list request. Each item
    /// includes stream session metadata and status.
    items: ?[]const StreamSessionSummary = null,

    /// A token that marks the start of the next sequential page of results. If an
    /// operation doesn't return a token, you've reached the end of the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamSessionsInput, options: CallOptions) !ListStreamSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamsessions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.export_files_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ExportFilesStatus=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamSessionsOutput {
    var result: ListStreamSessionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListStreamSessionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
