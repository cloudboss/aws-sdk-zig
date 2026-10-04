const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuggestAdditionalFeature = @import("suggest_additional_feature.zig").SuggestAdditionalFeature;
const SuggestFilter = @import("suggest_filter.zig").SuggestFilter;
const SuggestIntendedUse = @import("suggest_intended_use.zig").SuggestIntendedUse;
const SuggestTravelMode = @import("suggest_travel_mode.zig").SuggestTravelMode;
const QueryRefinement = @import("query_refinement.zig").QueryRefinement;
const SuggestResultItem = @import("suggest_result_item.zig").SuggestResultItem;

pub const SuggestInput = struct {
    /// A list of optional additional parameters, such as time zone, that can be
    /// requested for each result. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `Core` and `TimeZone` values.
    additional_features: ?[]const SuggestAdditionalFeature = null,

    /// The position, in longitude and latitude, that the results should be close
    /// to. Typically, place results returned are ranked higher the closer they are
    /// to this position. Stored in `[lng, lat]` and in the WGS 84 format.
    ///
    /// The fields `BiasPosition`, `FilterBoundingBox`, and `FilterCircle` are
    /// mutually exclusive.
    bias_position: ?[]const f64 = null,

    /// A structure which contains a set of inclusion/exclusion properties that
    /// results must possess in order to be returned as a result.
    filter: ?SuggestFilter = null,

    /// Indicates if the query results will be persisted in customer infrastructure.
    /// Defaults to `SingleUse` (not stored). Currently, `Suggest` does not support
    /// storage of results.
    intended_use: ?SuggestIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP
    /// 47](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry) compliant language codes for the results to be rendered in. If there is no data for the result in the requested language, data will be returned in the default language for the entry. For [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the following codes: `en, id, km, lo, ms, my, pt, th, tl, vi, zh`
    language: ?[]const u8 = null,

    /// Maximum number of query terms to be returned for use with a search text
    /// query. Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    max_query_refinements: ?i32 = null,

    /// An optional limit for the number of results returned in a single call.
    ///
    /// Default value: 20
    max_results: ?i32 = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    /// The free-form text query to match addresses against. This is usually a
    /// partially typed address from an end user in an address box or form.
    ///
    /// The fields `QueryText` and `QueryID` are mutually exclusive.
    query_text: []const u8,

    /// Indicates the mode of mobility used by the end user. This is used to improve
    /// the relevance of search results. Valid values are `Car`, `Scooter`, and
    /// `Truck`.
    travel_mode: ?SuggestTravelMode = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .bias_position = "BiasPosition",
        .filter = "Filter",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .max_query_refinements = "MaxQueryRefinements",
        .max_results = "MaxResults",
        .political_view = "PoliticalView",
        .query_text = "QueryText",
        .travel_mode = "TravelMode",
    };
};

pub const SuggestOutput = struct {
    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// Maximum number of query terms to be returned for use with a search text
    /// query. Not available in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    query_refinements: ?[]const QueryRefinement = null,

    /// List of places or results returned for a query.
    result_items: ?[]const SuggestResultItem = null,

    pub const json_field_names = .{
        .pricing_bucket = "PricingBucket",
        .query_refinements = "QueryRefinements",
        .result_items = "ResultItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SuggestInput, options: CallOptions) !SuggestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo-places", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SuggestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-places", "Geo Places", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/suggest";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdditionalFeatures\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bias_position) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BiasPosition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intended_use) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntendedUse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.language) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Language\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_query_refinements) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxQueryRefinements\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.political_view) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PoliticalView\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryText\":");
    try aws.json.writeValue(@TypeOf(input.query_text), input.query_text, allocator, &body_buf);
    has_prev = true;
    if (input.travel_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TravelMode\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SuggestOutput {
    var result: SuggestOutput = try aws.json.parseJsonObject(
        SuggestOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
