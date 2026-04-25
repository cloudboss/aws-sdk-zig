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

    /// The Business Chains associated with the place. Not available in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    business_chains: ?[]const BusinessChain = null,

    /// Categories of results that results must belong to.
    categories: ?[]const Category = null,

    /// The distance in meters from the QueryPosition.
    distance: i64 = 0,

    /// List of food types offered by this result. Not available in `ap-southeast-1`
    /// and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    food_types: ?[]const FoodType = null,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64 = null,

    /// How the various components of the result's address are pronounced in various
    /// languages. Not available in `ap-southeast-1` and `ap-southeast-5` regions
    /// for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    phonemes: ?PhonemeDetails = null,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: ?[]const u8 = null,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: ?PlaceType = null,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country. Not available in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    political_view: ?[]const u8 = null,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64 = null,

    /// The time zone in which the place is located.
    time_zone: ?TimeZone = null,

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
