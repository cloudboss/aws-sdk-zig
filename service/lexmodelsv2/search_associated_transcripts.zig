const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociatedTranscriptFilter = @import("associated_transcript_filter.zig").AssociatedTranscriptFilter;
const SearchOrder = @import("search_order.zig").SearchOrder;
const AssociatedTranscript = @import("associated_transcript.zig").AssociatedTranscript;

pub const SearchAssociatedTranscriptsInput = struct {
    /// The unique identifier of the bot associated with the transcripts
    /// that you are searching.
    bot_id: []const u8,

    /// The unique identifier of the bot recommendation associated with the
    /// transcripts to search.
    bot_recommendation_id: []const u8,

    /// The version of the bot containing the transcripts that you are
    /// searching.
    bot_version: []const u8,

    /// A list of filter objects.
    filters: []const AssociatedTranscriptFilter,

    /// The identifier of the language and locale of the transcripts to
    /// search. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: []const u8,

    /// The maximum number of bot recommendations to return in each page of
    /// results. If there are fewer results than the max page size, only the
    /// actual number of results are returned.
    max_results: ?i32 = null,

    /// If the response from the SearchAssociatedTranscriptsRequest
    /// operation contains more results than specified in the maxResults
    /// parameter, an index is returned in the response. Use that index in the
    /// nextIndex parameter to return the next page of results.
    next_index: ?i32 = null,

    /// How SearchResults are ordered. Valid values are Ascending or
    /// Descending. The default is Descending.
    search_order: ?SearchOrder = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_version = "botVersion",
        .filters = "filters",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_index = "nextIndex",
        .search_order = "searchOrder",
    };
};

pub const SearchAssociatedTranscriptsOutput = struct {
    /// The object that contains the associated transcript that meet the
    /// criteria you specified.
    associated_transcripts: ?[]const AssociatedTranscript = null,

    /// The unique identifier of the bot associated with the transcripts
    /// that you are searching.
    bot_id: ?[]const u8 = null,

    /// The unique identifier of the bot recommendation associated with the
    /// transcripts to search.
    bot_recommendation_id: ?[]const u8 = null,

    /// The version of the bot containing the transcripts that you are
    /// searching.
    bot_version: ?[]const u8 = null,

    /// The identifier of the language and locale of the transcripts to
    /// search. The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html)
    locale_id: ?[]const u8 = null,

    /// A index that indicates whether there are more results to return in a
    /// response to the SearchAssociatedTranscripts operation. If the nextIndex
    /// field is present, you send the contents as the nextIndex parameter of a
    /// SearchAssociatedTranscriptsRequest operation to get the next page of
    /// results.
    next_index: ?i32 = null,

    /// The total number of transcripts returned by the search.
    total_results: ?i32 = null,

    pub const json_field_names = .{
        .associated_transcripts = "associatedTranscripts",
        .bot_id = "botId",
        .bot_recommendation_id = "botRecommendationId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .next_index = "nextIndex",
        .total_results = "totalResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchAssociatedTranscriptsInput, options: CallOptions) !SearchAssociatedTranscriptsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchAssociatedTranscriptsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/botrecommendations/");
    try path_buf.appendSlice(allocator, input.bot_recommendation_id);
    try path_buf.appendSlice(allocator, "/associatedtranscripts");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"filters\":");
    try aws.json.writeValue(@TypeOf(input.filters), input.filters, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_index) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextIndex\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"searchOrder\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchAssociatedTranscriptsOutput {
    var result: SearchAssociatedTranscriptsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchAssociatedTranscriptsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
