const AccessPoint = @import("access_point.zig").AccessPoint;
const Address = @import("address.zig").Address;
const Category = @import("category.zig").Category;
const FoodType = @import("food_type.zig").FoodType;
const Intersection = @import("intersection.zig").Intersection;
const RelatedPlace = @import("related_place.zig").RelatedPlace;
const MatchScoreDetails = @import("match_score_details.zig").MatchScoreDetails;
const GeocodeParsedQuery = @import("geocode_parsed_query.zig").GeocodeParsedQuery;
const PlaceType = @import("place_type.zig").PlaceType;
const PostalCodeDetails = @import("postal_code_details.zig").PostalCodeDetails;
const TimeZone = @import("time_zone.zig").TimeZone;

/// The Geocoded result.
pub const GeocodeResultItem = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint = null,

    /// The place's address.
    address: ?Address = null,

    /// Boolean indicating if the address provided has been corrected.
    address_number_corrected: ?bool = null,

    /// Categories of results that results must belong to.
    categories: ?[]const Category = null,

    /// The distance in meters from the QueryPosition.
    distance: i64 = 0,

    /// List of food types offered by this result.
    food_types: ?[]const FoodType = null,

    /// All Intersections that are near the provided address.
    intersections: ?[]const Intersection = null,

    /// The main address corresponding to a place of type Secondary Address.
    main_address: ?RelatedPlace = null,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64 = null,

    /// Indicates how well the entire input matches the returned. It is equal to 1
    /// if all input tokens are recognized and matched.
    match_scores: ?MatchScoreDetails = null,

    /// Free-form text query.
    parsed_query: ?GeocodeParsedQuery = null,

    /// The `PlaceId` of the place result.
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
        .address = "Address",
        .address_number_corrected = "AddressNumberCorrected",
        .categories = "Categories",
        .distance = "Distance",
        .food_types = "FoodTypes",
        .intersections = "Intersections",
        .main_address = "MainAddress",
        .map_view = "MapView",
        .match_scores = "MatchScores",
        .parsed_query = "ParsedQuery",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .position = "Position",
        .postal_code_details = "PostalCodeDetails",
        .secondary_addresses = "SecondaryAddresses",
        .time_zone = "TimeZone",
        .title = "Title",
    };
};
