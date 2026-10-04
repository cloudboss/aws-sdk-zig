const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GetPlaceAdditionalFeature = @import("get_place_additional_feature.zig").GetPlaceAdditionalFeature;
const GetPlaceAddressNamesMode = @import("get_place_address_names_mode.zig").GetPlaceAddressNamesMode;
const GetPlaceIntendedUse = @import("get_place_intended_use.zig").GetPlaceIntendedUse;
const AccessPoint = @import("access_point.zig").AccessPoint;
const AccessRestriction = @import("access_restriction.zig").AccessRestriction;
const Address = @import("address.zig").Address;
const BusinessChain = @import("business_chain.zig").BusinessChain;
const Category = @import("category.zig").Category;
const Contacts = @import("contacts.zig").Contacts;
const CrossReference = @import("cross_reference.zig").CrossReference;
const FoodType = @import("food_type.zig").FoodType;
const RelatedPlace = @import("related_place.zig").RelatedPlace;
const OpeningHours = @import("opening_hours.zig").OpeningHours;
const PhonemeDetails = @import("phoneme_details.zig").PhonemeDetails;
const PlaceAttribute = @import("place_attribute.zig").PlaceAttribute;
const PlaceType = @import("place_type.zig").PlaceType;
const PostalCodeDetails = @import("postal_code_details.zig").PostalCodeDetails;
const TimeZone = @import("time_zone.zig").TimeZone;

pub const GetPlaceInput = struct {
    /// A list of optional additional parameters such as time zone that can be
    /// requested for each result. For
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the `TimeZone` value.
    additional_features: ?[]const GetPlaceAdditionalFeature = null,

    /// Specifies how address names are returned. When set to `Administrative`, the
    /// service returns the official administrative names for address components.
    /// `Administrative` currently applies only to addresses in the United States.
    address_names_mode: ?GetPlaceAddressNamesMode = null,

    /// Indicates if the query results will be persisted in customer infrastructure.
    /// Defaults to `SingleUse` (not stored). Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// When storing `GetPlace` responses, you *must* set this field to `Storage` to
    /// comply with the terms of service. These requests will be charged at a higher
    /// rate. Please review the [user
    /// agreement](https://aws.amazon.com/location/sla/) and [service pricing
    /// structure](https://aws.amazon.com/location/pricing/) to determine the
    /// correct setting for your use case.
    intended_use: ?GetPlaceIntendedUse = null,

    /// Optional: The API key to be used for authorization. Either an API key or
    /// valid SigV4 signature must be provided when making a request.
    key: ?[]const u8 = null,

    /// A list of [BCP
    /// 47](https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry) compliant language codes for the results to be rendered in. If there is no data for the result in the requested language, data will be returned in the default language for the entry. For [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only the following codes: `en, id, km, lo, ms, my, pt, th, tl, vi, zh`
    language: ?[]const u8 = null,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: []const u8,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_features = "AdditionalFeatures",
        .address_names_mode = "AddressNamesMode",
        .intended_use = "IntendedUse",
        .key = "Key",
        .language = "Language",
        .place_id = "PlaceId",
        .political_view = "PoliticalView",
    };
};

pub const GetPlaceOutput = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude]. Not available in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    access_points: ?[]const AccessPoint = null,

    /// Indicates known access restrictions on a vehicle access point. The index
    /// correlates to an access point and indicates if access through this point has
    /// some form of restriction. Not available in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    access_restrictions: ?[]const AccessRestriction = null,

    /// The place's address.
    address: ?Address = null,

    /// Boolean indicating if the address provided has been corrected. Not available
    /// in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    address_number_corrected: ?bool = null,

    /// The Business Chains associated with the place.
    business_chains: ?[]const BusinessChain = null,

    /// Categories of results that results must belong to.
    categories: ?[]const Category = null,

    /// List of potential contact methods for the result/place. Not available in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    contacts: ?Contacts = null,

    /// The list of supplier references available for this place. Requires the
    /// `CrossReferences` additional feature to be enabled.
    cross_references: ?[]const CrossReference = null,

    /// If `true`, indicates that the coordinates of the position and access points
    /// of the point address are estimated.
    estimated_point_address: ?bool = null,

    /// List of food types offered by this result. Not available in `ap-southeast-1`
    /// and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    food_types: ?[]const FoodType = null,

    /// The main address corresponding to a place of type Secondary Address. Not
    /// available in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    main_address: ?RelatedPlace = null,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set of four coordinates: `[{westward
    /// lng}, {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64 = null,

    /// List of opening hours objects. Not available in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    opening_hours: ?[]const OpeningHours = null,

    /// How the various components of the result's address are pronounced in various
    /// languages. Not available in `ap-southeast-1` and `ap-southeast-5` regions
    /// for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    phonemes: ?PhonemeDetails = null,

    /// A list of place attributes for the result, such as whether the business
    /// offers drive-through service.
    place_attributes: ?[]const PlaceAttribute = null,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: []const u8,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: PlaceType,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not available in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64 = null,

    /// Contains details about the postal code of the place/result. Not available in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    postal_code_details: ?[]const PostalCodeDetails = null,

    /// The pricing bucket for which the query is charged at.
    ///
    /// For more information on pricing, please visit [Amazon Location Service
    /// Pricing](https://aws.amazon.com/location/pricing/).
    pricing_bucket: []const u8,

    /// All secondary addresses that are associated with a main address. A secondary
    /// address is one that includes secondary designators, such as a Suite or Unit
    /// Number, Building, or Floor information. Not available in `ap-southeast-1`
    /// and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
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
        .cross_references = "CrossReferences",
        .estimated_point_address = "EstimatedPointAddress",
        .food_types = "FoodTypes",
        .main_address = "MainAddress",
        .map_view = "MapView",
        .opening_hours = "OpeningHours",
        .phonemes = "Phonemes",
        .place_attributes = "PlaceAttributes",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPlaceInput, options: CallOptions) !GetPlaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPlaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo-places", "Geo Places", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/place/");
    try path_buf.appendSlice(allocator, input.place_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.additional_features) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "additional-features=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.address_names_mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "address-names-mode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.intended_use) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "intended-use=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.key) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.language) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "language=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.political_view) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "political-view=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPlaceOutput {
    var result: GetPlaceOutput = try aws.json.parseJsonObject(
        GetPlaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    if (headers.get("x-amz-geo-pricing-bucket")) |value| {
        result.pricing_bucket = try allocator.dupe(u8, value);
    }

    return result;
}
