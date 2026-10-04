const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingGroupDocument = @import("thing_group_document.zig").ThingGroupDocument;
const ThingDocument = @import("thing_document.zig").ThingDocument;

pub const SearchIndexInput = struct {
    /// The search index name.
    index_name: ?[]const u8 = null,

    /// The maximum number of results to return per page at one time. This maximum
    /// number
    /// cannot exceed 100. The response might contain fewer results but will never
    /// contain more. You
    /// can use [
    /// `nextToken`
    /// ](https://docs.aws.amazon.com/iot/latest/apireference/API_SearchIndex.html#iot-SearchIndex-request-nextToken) to retrieve the next set of results until
    /// `nextToken` returns `NULL`.
    max_results: ?i32 = null,

    /// The token used to get the next set of results, or `null` if there are no
    /// additional
    /// results.
    next_token: ?[]const u8 = null,

    /// The search query string. For more information about the search query syntax,
    /// see [Query
    /// syntax](https://docs.aws.amazon.com/iot/latest/developerguide/query-syntax.html).
    query_string: []const u8,

    /// The query version.
    query_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_name = "indexName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_string = "queryString",
        .query_version = "queryVersion",
    };
};

pub const SearchIndexOutput = struct {
    /// The token used to get the next set of results, or `null` if there are no
    /// additional
    /// results.
    next_token: ?[]const u8 = null,

    /// The thing groups that match the search query.
    thing_groups: ?[]const ThingGroupDocument = null,

    /// The things that match the search query.
    things: ?[]const ThingDocument = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .thing_groups = "thingGroups",
        .things = "things",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchIndexInput, options: CallOptions) !SearchIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/indices/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.index_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexName\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryString\":");
    try aws.json.writeValue(@TypeOf(input.query_string), input.query_string, allocator, &body_buf);
    has_prev = true;
    if (input.query_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchIndexOutput {
    const result: SearchIndexOutput = try aws.json.parseJsonObject(
        SearchIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
