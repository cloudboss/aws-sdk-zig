const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GetPlaceAdditionalFeature = @import("get_place_additional_feature.zig").GetPlaceAdditionalFeature;
const GetPlaceIntendedUse = @import("get_place_intended_use.zig").GetPlaceIntendedUse;
const AccessPoint = @import("access_point.zig").AccessPoint;
const AccessRestriction = @import("access_restriction.zig").AccessRestriction;
const Address = @import("address.zig").Address;
const BusinessChain = @import("business_chain.zig").BusinessChain;
const Category = @import("category.zig").Category;
const Contacts = @import("contacts.zig").Contacts;
const FoodType = @import("food_type.zig").FoodType;
const RelatedPlace = @import("related_place.zig").RelatedPlace;
const OpeningHours = @import("opening_hours.zig").OpeningHours;
const PhonemeDetails = @import("phoneme_details.zig").PhonemeDetails;
const PlaceType = @import("place_type.zig").PlaceType;
const PostalCodeDetails = @import("postal_code_details.zig").PostalCodeDetails;
const TimeZone = @import("time_zone.zig").TimeZone;

pub const GetPlaceInput = struct {
    /// A list of optional additional parameters such as time zone that can be
    /// requested for each result.
    additional_features: ?[]const GetPlaceAdditionalFeature = null,

    /// Indicates if the results will be stored. Defaults to `SingleUse`, if left
    /// empty.
    ///
    /// Storing the response of an GetPlace query is required to comply with service
    /// terms, but charged at a higher cost per request. Please review the [user
    /// agreement](https://aws.amazon.com/location/sla/) and [service pricing
    /// structure](https://aws.amazon.com/location/pricing/) to determine the
    /// correct setting for your use case.
    intended_use: ?GetPlaceIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP 47](https://en.wikipedia.org/wiki/IETF_language_tag)
    /// compliant language codes for the results to be rendered in. If there is no
    /// data for the result in the requested language, data will be returned in the
    /// default language for the entry.
    language: ?[]const u8 = null,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: []const u8,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .place_id = "PlaceId",
        .political_view = "PoliticalView",
    };
};

pub const GetPlaceOutput = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint = null,

    /// Indicates known access restrictions on a vehicle access point. The index
    /// correlates to an access point and indicates if access through this point has
    /// some form of restriction.
    access_restrictions: ?[]const AccessRestriction = null,

    /// The place's address.
    address: ?Address = null,

    /// Boolean indicating if the address provided has been corrected.
    address_number_corrected: ?bool = null,

    /// The Business Chains associated with the place.
    business_chains: ?[]const BusinessChain = null,

    /// Categories of results that results must belong to.
    categories: ?[]const Category = null,

    /// List of potential contact methods for the result/place.
    contacts: ?Contacts = null,

    /// List of food types offered by this result.
    food_types: ?[]const FoodType = null,

    /// The main address corresponding to a place of type Secondary Address.
    main_address: ?RelatedPlace = null,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set of four coordinates: `[{westward
    /// lng}, {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64 = null,

    /// List of opening hours objects.
    opening_hours: ?[]const OpeningHours = null,

    /// How the various components of the result's address are pronounced in various
    /// languages.
    phonemes: ?PhonemeDetails = null,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: []const u8,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: PlaceType,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8 = null,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64 = null,

    /// Contains details about the postal code of the place/result.
    postal_code_details: ?[]const PostalCodeDetails = null,

    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// All secondary addresses that are associated with a main address. A secondary
    /// address is one that includes secondary designators, such as a Suite or Unit
    /// Number, Building, or Floor information.
    ///
    /// Coverage for this functionality is available in the following countries:
    /// AUS, CAN, NZL, USA, PRI.
    secondary_addresses: ?[]const RelatedPlace = null,

    /// The time zone in which the place is located.
    time_zone: ?TimeZone = null,

    /// The localized display name of this result item based on request parameter
    /// `language`.
    title: []const u8,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .access_restrictions = "AccessRestrictions",
        .address = "Address",
        .address_number_corrected = "AddressNumberCorrected",
        .business_chains = "BusinessChains",
        .categories = "Categories",
        .contacts = "Contacts",
        .food_types = "FoodTypes",
        .main_address = "MainAddress",
        .map_view = "MapView",
        .opening_hours = "OpeningHours",
        .phonemes = "Phonemes",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .position = "Position",
        .postal_code_details = "PostalCodeDetails",
        .pricing_bucket = "PricingBucket",
        .secondary_addresses = "SecondaryAddresses",
        .time_zone = "TimeZone",
        .title = "Title",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlaceInput, options: Options) !GetPlaceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetPlaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geoplaces", "Geo Places", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/place/");
    try path_buf.appendSlice(alloc, input.place_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.additional_features) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "additional-features=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.intended_use) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "intended-use=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.language) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "language=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.political_view) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "political-view=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetPlaceOutput {
    var result: GetPlaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPlaceOutput, body, alloc);
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
