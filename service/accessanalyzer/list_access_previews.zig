const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPreviewSummary = @import("access_preview_summary.zig").AccessPreviewSummary;

pub const ListAccessPreviewsInput = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) used to generate the access preview.
    analyzer_arn: []const u8,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAccessPreviewsOutput = struct {
    /// A list of access previews retrieved for the analyzer.
    access_previews: ?[]const AccessPreviewSummary = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_previews = "accessPreviews",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessPreviewsInput, options: CallOptions) !ListAccessPreviewsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessPreviewsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/access-preview";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "analyzerArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.analyzer_arn);
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessPreviewsOutput {
    var result: ListAccessPreviewsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAccessPreviewsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
