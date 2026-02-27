const AccessPoint = @import("access_point.zig").AccessPoint;
const AccessRestriction = @import("access_restriction.zig").AccessRestriction;
const Address = @import("address.zig").Address;
const BusinessChain = @import("business_chain.zig").BusinessChain;
const Category = @import("category.zig").Category;
const FoodType = @import("food_type.zig").FoodType;
const PhonemeDetails = @import("phoneme_details.zig").PhonemeDetails;
const PlaceType = @import("place_type.zig").PlaceType;
const TimeZone = @import("time_zone.zig").TimeZone;

/// The suggested place results.
pub const SuggestPlaceResult = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint,

    /// Indicates known access restrictions on a vehicle access point. The index
    /// correlates to an access point and indicates if access through this point has
    /// some form of restriction.
    access_restrictions: ?[]const AccessRestriction,

    /// The place's address.
    address: ?Address,

    /// The Business Chains associated with the place.
    business_chains: ?[]const BusinessChain,

    /// Categories of results that results must belong to.
    categories: ?[]const Category,

    /// The distance in meters from the QueryPosition.
    distance: i64 = 0,

    /// List of food types offered by this result.
    food_types: ?[]const FoodType,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64,

    /// How the various components of the result's address are pronounced in various
    /// languages.
    phonemes: ?PhonemeDetails,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: ?[]const u8,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: ?PlaceType,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64,

    /// The time zone in which the place is located.
    time_zone: ?TimeZone,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .access_restrictions = "AccessRestrictions",
        .address = "Address",
        .business_chains = "BusinessChains",
        .categories = "Categories",
        .distance = "Distance",
        .food_types = "FoodTypes",
        .map_view = "MapView",
        .phonemes = "Phonemes",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .position = "Position",
        .time_zone = "TimeZone",
    };
};
