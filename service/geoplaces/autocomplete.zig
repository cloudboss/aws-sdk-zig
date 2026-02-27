const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutocompleteAdditionalFeature = @import("autocomplete_additional_feature.zig").AutocompleteAdditionalFeature;
const AutocompleteFilter = @import("autocomplete_filter.zig").AutocompleteFilter;
const AutocompleteIntendedUse = @import("autocomplete_intended_use.zig").AutocompleteIntendedUse;
const PostalCodeMode = @import("postal_code_mode.zig").PostalCodeMode;
const AutocompleteResultItem = @import("autocomplete_result_item.zig").AutocompleteResultItem;

pub const AutocompleteInput = struct {
    /// A list of optional additional parameters that can be requested for each
    /// result.
    additional_features: ?[]const AutocompleteAdditionalFeature = null,

    /// The position in longitude and latitude that the results should be close to.
    /// Typically, place results returned are ranked higher the closer they are to
    /// this position. Stored in `[lng, lat]` and in the WGS 84 format.
    ///
    /// The fields `BiasPosition`, `FilterBoundingBox`, and `FilterCircle` are
    /// mutually exclusive.
    bias_position: ?[]const f64 = null,

    /// A structure which contains a set of inclusion/exclusion properties that
    /// results must possess in order to be returned as a result.
    filter: ?AutocompleteFilter = null,

    /// Indicates if the results will be stored. Defaults to `SingleUse`, if left
    /// empty.
    intended_use: ?AutocompleteIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag)
    /// compliant language codes for the results to be rendered in. If there is no
    /// data for the result in the requested language, data will be returned in the
    /// default language for the entry.
    language: ?[]const u8 = null,

    /// An optional limit for the number of results returned in a single call.
    ///
    /// Default value: 5
    max_results: ?i32 = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    ///
    /// The following political views are currently supported:
    ///
    /// * `ARG`: Argentina's view on the Southern Patagonian Ice Field and Tierra
    ///   Del Fuego, including the Falkland Islands, South Georgia, and South
    ///   Sandwich Islands
    /// * `EGY`: Egypt's view on Bir Tawil
    /// * `IND`: India's view on Gilgit-Baltistan
    /// * `KEN`: Kenya's view on the Ilemi Triangle
    /// * `MAR`: Morocco's view on Western Sahara
    /// * `RUS`: Russia's view on Crimea
    /// * `SDN`: Sudan's view on the Halaib Triangle
    /// * `SRB`: Serbia's view on Kosovo, Vukovar, and Sarengrad Islands
    /// * `SUR`: Suriname's view on the Courantyne Headwaters and Lawa Headwaters
    /// * `SYR`: Syria's view on the Golan Heights
    /// * `TUR`: Turkey's view on Cyprus and Northern Cyprus
    /// * `TZA`: Tanzania's view on Lake Malawi
    /// * `URY`: Uruguay's view on Rincon de Artigas
    /// * `VNM`: Vietnam's view on the Paracel Islands and Spratly Islands
    political_view: ?[]const u8 = null,

    /// The `PostalCodeMode` affects how postal code results are returned. If a
    /// postal code spans multiple localities and this value is empty, partial
    /// district or locality information may be returned under a single postal code
    /// result entry. If it's populated with the value `EnumerateSpannedLocalities`,
    /// all cities in that postal code are returned.
    postal_code_mode: ?PostalCodeMode = null,

    /// The free-form text query to match addresses against. This is usually a
    /// partially typed address from an end user in an address box or form.
    ///
    /// The fields `QueryText`, and `QueryID` are mutually exclusive.
    query_text: []const u8,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .bias_position = "BiasPosition",
        .filter = "Filter",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .max_results = "MaxResults",
        .political_view = "PoliticalView",
        .postal_code_mode = "PostalCodeMode",
        .query_text = "QueryText",
    };
};

pub const AutocompleteOutput = struct {
    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// List of places or results returned for a query.
    result_items: ?[]const AutocompleteResultItem = null,

    pub const json_field_names = .{
        .pricing_bucket = "PricingBucket",
        .result_items = "ResultItems",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AutocompleteInput, options: Options) !AutocompleteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geoplaces");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: AutocompleteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geoplaces", "Geo Places", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/autocomplete";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.additional_features) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdditionalFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.bias_position) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"BiasPosition\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.intended_use) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IntendedUse\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.language) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Language\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.political_view) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PoliticalView\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.postal_code_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"PostalCodeMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"QueryText\":");
    try aws.json.writeValue(@TypeOf(input.query_text), input.query_text, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AutocompleteOutput {
    var result: AutocompleteOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AutocompleteOutput, body, alloc);
    }
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try alloc.dupe(u8, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
