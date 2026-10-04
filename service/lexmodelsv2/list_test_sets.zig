const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TestSetSortBy = @import("test_set_sort_by.zig").TestSetSortBy;
const TestSetSummary = @import("test_set_summary.zig").TestSetSummary;

pub const ListTestSetsInput = struct {
    /// The maximum number of test sets to return in each page. If there are fewer
    /// results than the max page size, only the actual number of results are
    /// returned.
    max_results: ?i32 = null,

    /// If the response from the ListTestSets operation contains more results than
    /// specified in the maxResults parameter, a token is returned in the response.
    /// Use
    /// that token in the nextToken parameter to return the next page of results.
    next_token: ?[]const u8 = null,

    /// The sort order for the list of test sets.
    sort_by: ?TestSetSortBy = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListTestSetsOutput = struct {
    /// A token that indicates whether there are more results to return in a
    /// response
    /// to the ListTestSets operation. If the nextToken field is present, you send
    /// the
    /// contents as the nextToken parameter of a ListTestSets operation request to
    /// get
    /// the next page of results.
    next_token: ?[]const u8 = null,

    /// The selected test sets in a list of test sets.
    test_sets: ?[]const TestSetSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .test_sets = "testSets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTestSetsInput, options: CallOptions) !ListTestSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTestSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/testsets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTestSetsOutput {
    var result: ListTestSetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListTestSetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
