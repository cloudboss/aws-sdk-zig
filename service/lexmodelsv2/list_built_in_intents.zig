const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BuiltInIntentSortBy = @import("built_in_intent_sort_by.zig").BuiltInIntentSortBy;
const BuiltInIntentSummary = @import("built_in_intent_summary.zig").BuiltInIntentSummary;

pub const ListBuiltInIntentsInput = struct {
    /// The identifier of the language and locale of the intents to list.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The maximum number of built-in intents to return in each page of
    /// results. If there are fewer results than the max page size, only the
    /// actual number of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListBuiltInIntents` operation
    /// contains more results than specified in the `maxResults`
    /// parameter, a token is returned in the response. Use that token in the
    /// `nextToken` parameter to return the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// Specifies sorting parameters for the list of built-in intents. You
    /// can specify that the list be sorted by the built-in intent signature in
    /// either ascending or descending order.
    sort_by: ?BuiltInIntentSortBy = null,

    pub const json_field_names = .{
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListBuiltInIntentsOutput = struct {
    /// Summary information for the built-in intents that meet the filter
    /// criteria specified in the request. The length of the list is specified
    /// in the `maxResults` parameter of the request. If there are
    /// more intents available, the `nextToken` field contains a
    /// token to get the next page of results.
    built_in_intent_summaries: ?[]const BuiltInIntentSummary = null,

    /// The language and locale of the intents in the list.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListBuiltInIntents` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListBotAliases`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .built_in_intent_summaries = "builtInIntentSummaries",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBuiltInIntentsInput, options: CallOptions) !ListBuiltInIntentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBuiltInIntentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/builtins/locales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/intents");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBuiltInIntentsOutput {
    const result: ListBuiltInIntentsOutput = try aws.json.parseJsonObject(
        ListBuiltInIntentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
