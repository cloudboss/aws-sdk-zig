const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchTextAdditionalFeature = @import("search_text_additional_feature.zig").SearchTextAdditionalFeature;
const SearchTextFilter = @import("search_text_filter.zig").SearchTextFilter;
const SearchTextIntendedUse = @import("search_text_intended_use.zig").SearchTextIntendedUse;
const SearchTextResultItem = @import("search_text_result_item.zig").SearchTextResultItem;

pub const SearchTextInput = struct {
    /// A list of optional additional parameters, such as time zone, that can be
    /// requested for each result. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `TimeZone` value.
    additional_features: ?[]const SearchTextAdditionalFeature = null,

    /// The position, in longitude and latitude, that the results should be close
    /// to. Typically, place results returned are ranked higher the closer they are
    /// to this position. Stored in `[lng, lat]` and in the WGS 84 format.
    ///
    /// Exactly one of the following fields must be set: `BiasPosition`,
    /// `Filter.BoundingBox`, or `Filter.Circle`.
    bias_position: ?[]const f64 = null,

    /// A structure which contains a set of inclusion/exclusion properties that
    /// results must possess in order to be returned as a result.
    filter: ?SearchTextFilter = null,

    /// Indicates if the query results will be persisted in customer infrastructure.
    /// Defaults to `SingleUse` (not stored).
    ///
    /// When storing `SearchText` responses, you *must* set this field to `Storage`
    /// to comply with the terms of service. These requests will be charged at a
    /// higher rate. Please review the [user
    /// agreement](https://aws.amazon.com/location/sla/) and [service pricing
    /// structure](https://aws.amazon.com/location/pricing/) to determine the
    /// correct setting for your use case.
    intended_use: ?SearchTextIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag)
    /// compliant language codes for the results to be rendered in. If there is no
    /// data for the result in the requested language, data will be returned in the
    /// default language for the entry. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the following codes: `en, id, km, lo, ms, my, pt, th, tl, vi, zh`
    language: ?[]const u8 = null,

    /// An optional limit for the number of results returned in a single call.
    ///
    /// Default value: 20
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    next_token: ?[]const u8 = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not available in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    /// The query Id returned by the suggest API. If passed in the request, the
    /// SearchText API will preform a SearchText query with the improved query terms
    /// for the original query made to the suggest API. Not available in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// Exactly one of the following fields must be set: `QueryText` or `QueryId`.
    query_id: ?[]const u8 = null,

    /// The free-form text query to match addresses against. This is usually a
    /// partially typed address from an end user in an address box or form.
    ///
    /// Exactly one of the following fields must be set: `QueryText` or `QueryId`.
    query_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .bias_position = "BiasPosition",
        .filter = "Filter",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .political_view = "PoliticalView",
        .query_id = "QueryId",
        .query_text = "QueryText",
    };
};

pub const SearchTextOutput = struct {
    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page.
    next_token: ?[]const u8 = null,

    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// List of places or results returned for a query.
    result_items: ?[]const SearchTextResultItem = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .pricing_bucket = "PricingBucket",
        .result_items = "ResultItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchTextInput, options: CallOptions) !SearchTextOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchTextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-places", "Geo Places", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/search-text";

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
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.political_view) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PoliticalView\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryText\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchTextOutput {
    var result: SearchTextOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchTextOutput, body, allocator);
    }
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
