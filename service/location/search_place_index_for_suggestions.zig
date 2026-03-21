const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SearchForSuggestionsResult = @import("search_for_suggestions_result.zig").SearchForSuggestionsResult;
const SearchPlaceIndexForSuggestionsSummary = @import("search_place_index_for_suggestions_summary.zig").SearchPlaceIndexForSuggestionsSummary;

pub const SearchPlaceIndexForSuggestionsInput = struct {
    /// An optional parameter that indicates a preference for place suggestions that
    /// are closer to a specified position.
    ///
    /// If provided, this parameter must contain a pair of numbers. The first number
    /// represents the X coordinate, or longitude; the second number represents the
    /// Y coordinate, or latitude.
    ///
    /// For example, `[-123.1174, 49.2847]` represents the position with longitude
    /// `-123.1174` and latitude `49.2847`.
    ///
    /// `BiasPosition` and `FilterBBox` are mutually exclusive. Specifying both
    /// options results in an error.
    bias_position: ?[]const f64 = null,

    /// An optional parameter that limits the search results by returning only
    /// suggestions within a specified bounding box.
    ///
    /// If provided, this parameter must contain a total of four consecutive numbers
    /// in two pairs. The first pair of numbers represents the X and Y coordinates
    /// (longitude and latitude, respectively) of the southwest corner of the
    /// bounding box; the second pair of numbers represents the X and Y coordinates
    /// (longitude and latitude, respectively) of the northeast corner of the
    /// bounding box.
    ///
    /// For example, `[-12.7935, -37.4835, -12.0684, -36.9542]` represents a
    /// bounding box where the southwest corner has longitude `-12.7935` and
    /// latitude `-37.4835`, and the northeast corner has longitude `-12.0684` and
    /// latitude `-36.9542`.
    ///
    /// `FilterBBox` and `BiasPosition` are mutually exclusive. Specifying both
    /// options results in an error.
    filter_b_box: ?[]const f64 = null,

    /// A list of one or more Amazon Location categories to filter the returned
    /// places. If you include more than one category, the results will include
    /// results that match *any* of the categories listed.
    ///
    /// For more information about using categories, including a list of Amazon
    /// Location categories, see [Categories and
    /// filtering](https://docs.aws.amazon.com/location/previous/developerguide/category-filtering.html), in the *Amazon Location Service developer guide*.
    filter_categories: ?[]const []const u8 = null,

    /// An optional parameter that limits the search results by returning only
    /// suggestions within the provided list of countries.
    ///
    /// * Use the [ISO 3166](https://www.iso.org/iso-3166-country-codes.html)
    ///   3-digit country code. For example, Australia uses three upper-case
    ///   characters: `AUS`.
    filter_countries: ?[]const []const u8 = null,

    /// The name of the place index resource you want to use for the search.
    index_name: []const u8,

    /// The optional [API
    /// key](https://docs.aws.amazon.com/location/previous/developerguide/using-apikeys.html) to authorize the request.
    key: ?[]const u8 = null,

    /// The preferred language used to return results. The value must be a valid
    /// [BCP 47](https://tools.ietf.org/search/bcp47) language tag, for example,
    /// `en` for English.
    ///
    /// This setting affects the languages used in the results. If no language is
    /// specified, or not supported for a particular result, the partner
    /// automatically chooses a language for the result.
    ///
    /// For an example, we'll use the Greek language. You search for `Athens, Gr` to
    /// get suggestions with the `language` parameter set to `en`. The results found
    /// will most likely be returned as `Athens, Greece`.
    ///
    /// If you set the `language` parameter to `el`, for Greek, then the result
    /// found will more likely be returned as `Αθήνα, Ελλάδα`.
    ///
    /// If the data provider does not have a value for Greek, the result will be in
    /// a language that the provider does support.
    language: ?[]const u8 = null,

    /// An optional parameter. The maximum number of results returned per request.
    ///
    /// The default: `5`
    max_results: ?i32 = null,

    /// The free-form partial text to use to generate place suggestions. For
    /// example, `eiffel tow`.
    text: []const u8,

    pub const json_field_names = .{
        .bias_position = "BiasPosition",
        .filter_b_box = "FilterBBox",
        .filter_categories = "FilterCategories",
        .filter_countries = "FilterCountries",
        .index_name = "IndexName",
        .key = "Key",
        .language = "Language",
        .max_results = "MaxResults",
        .text = "Text",
    };
};

pub const SearchPlaceIndexForSuggestionsOutput = struct {
    /// A list of place suggestions that best match the search text.
    results: ?[]const SearchForSuggestionsResult = null,

    /// Contains a summary of the request. Echoes the input values for
    /// `BiasPosition`, `FilterBBox`, `FilterCountries`, `Language`, `MaxResults`,
    /// and `Text`. Also includes the `DataSource` of the place index.
    summary: ?SearchPlaceIndexForSuggestionsSummary = null,

    pub const json_field_names = .{
        .results = "Results",
        .summary = "Summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchPlaceIndexForSuggestionsInput, options: CallOptions) !SearchPlaceIndexForSuggestionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: SearchPlaceIndexForSuggestionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/places/v0/indexes/");
    try path_buf.appendSlice(allocator, input.index_name);
    try path_buf.appendSlice(allocator, "/search/suggestions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bias_position) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BiasPosition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_b_box) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterBBox\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_categories) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterCategories\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_countries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterCountries\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.language) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Language\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Text\":");
    try aws.json.writeValue(@TypeOf(input.text), input.text, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchPlaceIndexForSuggestionsOutput {
    var result: SearchPlaceIndexForSuggestionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchPlaceIndexForSuggestionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
