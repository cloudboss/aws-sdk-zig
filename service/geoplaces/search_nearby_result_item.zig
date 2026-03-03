const AccessPoint = @import("access_point.zig").AccessPoint;
const AccessRestriction = @import("access_restriction.zig").AccessRestriction;
const Address = @import("address.zig").Address;
const BusinessChain = @import("business_chain.zig").BusinessChain;
const Category = @import("category.zig").Category;
const Contacts = @import("contacts.zig").Contacts;
const FoodType = @import("food_type.zig").FoodType;
const OpeningHours = @import("opening_hours.zig").OpeningHours;
const PhonemeDetails = @import("phoneme_details.zig").PhonemeDetails;
const PlaceType = @import("place_type.zig").PlaceType;
const TimeZone = @import("time_zone.zig").TimeZone;

/// The search results of nearby places.
pub const SearchNearbyResultItem = struct {
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

    /// The distance in meters from the QueryPosition.
    distance: i64 = 0,

    /// List of food types offered by this result.
    food_types: ?[]const FoodType = null,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
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

    /// The time zone in which the place is located.
    time_zone: ?TimeZone = null,

    /// The item's title.
    title: []const u8,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .access_restrictions = "AccessRestrictions",
        .address = "Address",
        .address_number_corrected = "AddressNumberCorrected",
        .business_chains = "BusinessChains",
        .categories = "Categories",
        .contacts = "Contacts",
        .distance = "Distance",
        .food_types = "FoodTypes",
        .map_view = "MapView",
        .opening_hours = "OpeningHours",
        .phonemes = "Phonemes",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .position = "Position",
        .time_zone = "TimeZone",
        .title = "Title",
    };
};
