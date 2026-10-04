const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportFilter = @import("export_filter.zig").ExportFilter;
const ExportSortBy = @import("export_sort_by.zig").ExportSortBy;
const ExportSummary = @import("export_summary.zig").ExportSummary;

pub const ListExportsInput = struct {
    /// The unique identifier that Amazon Lex assigned to the bot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot to list exports for.
    bot_version: ?[]const u8 = null,

    /// Provides the specification of a filter used to limit the exports in
    /// the response to only those that match the filter specification. You can
    /// only specify one filter and one string to filter on.
    filters: ?[]const ExportFilter = null,

    /// Specifies the resources that should be exported. If you
    /// don't specify a resource type in the `filters` parameter,
    /// both bot locales and custom vocabularies are exported.
    locale_id: ?[]const u8 = null,

    /// The maximum number of exports to return in each page of results. If
    /// there are fewer results than the max page size, only the actual number
    /// of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListExports` operation contains
    /// more results that specified in the `maxResults` parameter, a
    /// token is returned in the response.
    ///
    /// Use the returned token in the `nextToken` parameter of a
    /// `ListExports` request to return the next page of results.
    /// For a complete set of results, call the `ListExports`
    /// operation until the `nextToken` returned in the response is
    /// null.
    next_token: ?[]const u8 = null,

    /// Determines the field that the list of exports is sorted by. You can
    /// sort by the `LastUpdatedDateTime` field in ascending or
    /// descending order.
    sort_by: ?ExportSortBy = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .filters = "filters",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListExportsOutput = struct {
    /// The unique identifier assigned to the bot by Amazon Lex.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that was exported.
    bot_version: ?[]const u8 = null,

    /// Summary information for the exports that meet the filter criteria
    /// specified in the request. The length of the list is specified in the
    /// `maxResults` parameter. If there are more exports
    /// available, the `nextToken` field contains a token to get the
    /// next page of results.
    export_summaries: ?[]const ExportSummary = null,

    /// The locale specified in the request.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListExports` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListExports`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .export_summaries = "exportSummaries",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportsInput, options: CallOptions) !ListExportsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exports";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bot_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.locale_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localeId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportsOutput {
    const result: ListExportsOutput = try aws.json.parseJsonObject(
        ListExportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
