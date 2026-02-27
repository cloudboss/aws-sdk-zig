const AccessPoint = @import("access_point.zig").AccessPoint;
const Address = @import("address.zig").Address;
const Category = @import("category.zig").Category;
const FoodType = @import("food_type.zig").FoodType;
const Intersection = @import("intersection.zig").Intersection;
const PlaceType = @import("place_type.zig").PlaceType;
const PostalCodeDetails = @import("postal_code_details.zig").PostalCodeDetails;
const TimeZone = @import("time_zone.zig").TimeZone;

/// The returned location from the `Reverse Geocode` action.
pub const ReverseGeocodeResultItem = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint,

    /// The place's address.
    address: ?Address,

    /// Boolean indicating if the address provided has been corrected.
    address_number_corrected: ?bool,

    /// Categories of results that results must belong to.
    categories: ?[]const Category,

    /// The distance in meters from the QueryPosition.
    distance: i64 = 0,

    /// List of food types offered by this result.
    food_types: ?[]const FoodType,

    /// All Intersections that are near the provided address.
    intersections: ?[]const Intersection,

    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    map_view: ?[]const f64,

    /// The `PlaceId` of the place you wish to receive the information for.
    place_id: []const u8,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: PlaceType,

    /// The alpha-2 or alpha-3 character code for the political view of a country.
    /// The political view applies to the results of the request to represent
    /// unresolved territorial claims through the point of view of the specified
    /// country.
    political_view: ?[]const u8,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64,

    /// Contains details about the postal code of the place/result.
    postal_code_details: ?[]const PostalCodeDetails,

    /// The time zone in which the place is located.
    time_zone: ?TimeZone,

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
        .map_view = "MapView",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .political_view = "PoliticalView",
        .position = "Position",
        .postal_code_details = "PostalCodeDetails",
        .time_zone = "TimeZone",
        .title = "Title",
    };
};
