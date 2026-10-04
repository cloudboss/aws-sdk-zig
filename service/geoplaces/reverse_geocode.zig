const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReverseGeocodeAdditionalFeature = @import("reverse_geocode_additional_feature.zig").ReverseGeocodeAdditionalFeature;
const ReverseGeocodeAddressNamesMode = @import("reverse_geocode_address_names_mode.zig").ReverseGeocodeAddressNamesMode;
const ReverseGeocodeFilter = @import("reverse_geocode_filter.zig").ReverseGeocodeFilter;
const ReverseGeocodeIntendedUse = @import("reverse_geocode_intended_use.zig").ReverseGeocodeIntendedUse;
const ReverseGeocodeResultItem = @import("reverse_geocode_result_item.zig").ReverseGeocodeResultItem;

pub const ReverseGeocodeInput = struct {
    /// A list of optional additional parameters, such as time zone that can be
    /// requested for each result. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `TimeZone` value.
    additional_features: ?[]const ReverseGeocodeAdditionalFeature = null,

    /// Specifies how address names are returned. When set to `Administrative`, the
    /// service returns the official administrative names for address components.
    /// `Administrative` currently applies only to addresses in the United States.
    address_names_mode: ?ReverseGeocodeAddressNamesMode = null,

    /// A structure which contains a set of inclusion/exclusion properties that
    /// results must possess in order to be returned as a result.
    filter: ?ReverseGeocodeFilter = null,

    /// The heading in degrees from true north in a navigation context. The heading
    /// is measured as the angle clockwise from the North direction.
    ///
    /// Example: North is `0` degrees, East is `90` degrees, South is `180` degrees,
    /// and West is `270` degrees.
    heading: ?f64 = null,

    /// Indicates if the query results will be persisted in customer infrastructure.
    /// Defaults to `SingleUse` (not stored).
    ///
    /// When storing `ReverseGeocode` responses, you *must* set this field to
    /// `Storage` to comply with the terms of service. These requests will be
    /// charged at a higher rate. Please review the [user
    /// agreement](https://aws.amazon.com/location/sla/) and [service pricing
    /// structure](https://aws.amazon.com/location/pricing/) to determine the
    /// correct setting for your use case.
    intended_use: ?ReverseGeocodeIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP
    /// 47](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry) compliant language codes for the results to be rendered in. If there is no data for the result in the requested language, data will be returned in the default language for the entry. For [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the following codes: `en, id, km, lo, ms, my, pt, th, tl, vi, zh`
    language: ?[]const u8 = null,

    /// An optional limit for the number of results returned in a single call.
    ///
    /// Default value: 1
    max_results: ?i32 = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    /// The position in World Geodetic System (WGS 84) format: [longitude, latitude]
    /// for which you are querying nearby results for. Results closer to the
    /// position will be ranked higher then results further away from the position
    query_position: []const f64,

    /// The maximum distance in meters from the QueryPosition from which a result
    /// will be returned. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only up to a maximum value of 100,000.
    query_radius: ?i64 = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .address_names_mode = "AddressNamesMode",
        .filter = "Filter",
        .heading = "Heading",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .max_results = "MaxResults",
        .political_view = "PoliticalView",
        .query_position = "QueryPosition",
        .query_radius = "QueryRadius",
    };
};

pub const ReverseGeocodeOutput = struct {
    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// List of places or results returned for a query.
    result_items: ?[]const ReverseGeocodeResultItem = null,

    pub const json_field_names = .{
        .pricing_bucket = "PricingBucket",
        .result_items = "ResultItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReverseGeocodeInput, options: CallOptions) !ReverseGeocodeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReverseGeocodeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-places", "Geo Places", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/reverse-geocode";

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
    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.heading) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Heading\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryPosition\":");
    try aws.json.writeValue(@TypeOf(input.query_position), input.query_position, allocator, &body_buf);
    has_prev = true;
    if (input.query_radius) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"QueryRadius\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReverseGeocodeOutput {
    var result: ReverseGeocodeOutput = try aws.json.parseJsonObject(
        ReverseGeocodeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
