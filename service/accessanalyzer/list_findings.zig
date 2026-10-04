const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Criterion = @import("criterion.zig").Criterion;
const SortCriteria = @import("sort_criteria.zig").SortCriteria;
const FindingSummary = @import("finding_summary.zig").FindingSummary;

pub const ListFindingsInput = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) to retrieve findings from.
    analyzer_arn: []const u8,

    /// A filter to match for the findings to return.
    filter: ?[]const aws.map.MapEntry(Criterion) = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    /// The sort order for the findings returned.
    sort: ?SortCriteria = null,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort = "sort",
    };
};

pub const ListFindingsOutput = struct {
    /// A list of findings retrieved from the analyzer that match the filter
    /// criteria specified, if any.
    findings: ?[]const FindingSummary = null,

    /// A token used for pagination of results returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "findings",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsInput, options: CallOptions) !ListFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/finding";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analyzerArn\":");
    try aws.json.writeValue(@TypeOf(input.analyzer_arn), input.analyzer_arn, allocator, &body_buf);
    has_prev = true;
    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sort\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsOutput {
    const result: ListFindingsOutput = try aws.json.parseJsonObject(
        ListFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
