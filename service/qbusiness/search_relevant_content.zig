const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const ContentSource = @import("content_source.zig").ContentSource;
const RelevantContent = @import("relevant_content.zig").RelevantContent;

pub const SearchRelevantContentInput = struct {
    /// The unique identifier of the Amazon Q Business application to search.
    application_id: []const u8,

    attribute_filter: ?AttributeFilter = null,

    /// The source of content to search in.
    content_source: ContentSource,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// The token for the next set of results. (You received this token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    /// The text to search for.
    query_text: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .attribute_filter = "attributeFilter",
        .content_source = "contentSource",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .query_text = "queryText",
    };
};

pub const SearchRelevantContentOutput = struct {
    /// The token to use to retrieve the next set of results, if there are any.
    next_token: ?[]const u8 = null,

    /// The list of relevant content items found.
    relevant_content: ?[]const RelevantContent = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .relevant_content = "relevantContent",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchRelevantContentInput, options: CallOptions) !SearchRelevantContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchRelevantContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/relevant-content");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attribute_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributeFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentSource\":");
    try aws.json.writeValue(@TypeOf(input.content_source), input.content_source, allocator, &body_buf);
    has_prev = true;
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
    try body_buf.appendSlice(allocator, "\"queryText\":");
    try aws.json.writeValue(@TypeOf(input.query_text), input.query_text, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchRelevantContentOutput {
    var result: SearchRelevantContentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchRelevantContentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
