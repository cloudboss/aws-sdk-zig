const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeocodeAdditionalFeature = @import("geocode_additional_feature.zig").GeocodeAdditionalFeature;
const GeocodeAddressNamesMode = @import("geocode_address_names_mode.zig").GeocodeAddressNamesMode;
const AddressTranslationComponent = @import("address_translation_component.zig").AddressTranslationComponent;
const GeocodeFilter = @import("geocode_filter.zig").GeocodeFilter;
const GeocodeIntendedUse = @import("geocode_intended_use.zig").GeocodeIntendedUse;
const PostalCodeMode = @import("postal_code_mode.zig").PostalCodeMode;
const GeocodeQueryComponents = @import("geocode_query_components.zig").GeocodeQueryComponents;
const GeocodeResultItem = @import("geocode_result_item.zig").GeocodeResultItem;

pub const GeocodeInput = struct {
    /// A list of optional additional parameters, such as time zone, that can be
    /// requested for each result.
    additional_features: ?[]const GeocodeAdditionalFeature = null,

    /// Specifies how address names are returned. If not set, the service returns
    /// normalized (official) names by default. When set to `Matched`, address names
    /// in the response are based on the input query rather than official names.
    /// When set to `Administrative`, the service returns the official
    /// administrative names for address components. `Administrative` currently
    /// applies only to addresses in the United States.
    address_names_mode: ?GeocodeAddressNamesMode = null,

    /// Specifies which address components to include translations for. Translations
    /// include all name variants and alternative names for the requested fields in
    /// all available languages. Valid values are `District`, `Locality`, `Region`,
    /// and `SubRegion`.
    address_translations: ?[]const AddressTranslationComponent = null,

    /// The position, in longitude and latitude, that the results should be close
    /// to. Typically, place results returned are ranked higher the closer they are
    /// to this position. Stored in `[lng, lat]` and in the WGS 84 format.
    bias_position: ?[]const f64 = null,

    /// A structure which contains a set of inclusion/exclusion properties that
    /// results must possess in order to be returned as a result.
    filter: ?GeocodeFilter = null,

    /// Indicates if the query results will be persisted in customer infrastructure.
    /// Defaults to `SingleUse` (not stored). Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// When storing `Geocode` responses, you *must* set this field to `Storage` to
    /// comply with the terms of service. These requests will be charged at a higher
    /// rate. Please review the [user
    /// agreement](https://aws.amazon.com/location/sla/) and [service pricing
    /// structure](https://aws.amazon.com/location/pricing/) to determine the
    /// correct setting for your use case.
    intended_use: ?GeocodeIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP
    /// 47](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry) compliant language codes for the results to be rendered in. If there is no data for the result in the requested language, data will be returned in the default language for the entry.
    language: ?[]const u8 = null,

    /// An optional limit for the number of results returned in a single call.
    ///
    /// Default value: 20
    max_results: ?i32 = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8 = null,

    /// The `PostalCodeMode` affects how postal code results are returned. If a
    /// postal code spans multiple localities and this value is empty, partial
    /// district or locality information may be returned under a single postal code
    /// result entry. If it's populated with the value `EnumerateSpannedLocalities`,
    /// all cities in that postal code are returned. If it's populated with the
    /// value `EnumerateSpannedDistricts`, all combinations of the postal code with
    /// the corresponding district and city names are returned.
    postal_code_mode: ?PostalCodeMode = null,

    query_components: ?GeocodeQueryComponents = null,

    /// The free-form text query to match addresses against. This is usually a
    /// partially typed address from an end user in an address box or form.
    query_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .address_names_mode = "AddressNamesMode",
        .address_translations = "AddressTranslations",
        .bias_position = "BiasPosition",
        .filter = "Filter",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .max_results = "MaxResults",
        .political_view = "PoliticalView",
        .postal_code_mode = "PostalCodeMode",
        .query_components = "QueryComponents",
        .query_text = "QueryText",
    };
};

pub const GeocodeOutput = struct {
    /// The pricing bucket for which the query is charged at, or the maximum pricing
    /// bucket when the query is charged per item within the query.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// List of places or results returned for a query.
    result_items: ?[]const GeocodeResultItem = null,

    pub const json_field_names = .{
        .pricing_bucket = "PricingBucket",
        .result_items = "ResultItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GeocodeInput, options: CallOptions) !GeocodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GeocodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-places", "Geo Places", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/geocode";

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
    if (input.address_names_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AddressNamesMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.address_translations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AddressTranslations\":");
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
    if (input.political_view) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PoliticalView\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.postal_code_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PostalCodeMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_components) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryComponents\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GeocodeOutput {
    var result: GeocodeOutput = try aws.json.parseJsonObject(
        GeocodeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
