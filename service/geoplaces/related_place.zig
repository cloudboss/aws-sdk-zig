const AccessPoint = @import("access_point.zig").AccessPoint;
const Address = @import("address.zig").Address;
const PlaceType = @import("place_type.zig").PlaceType;

/// Place that is related to the result item.
pub const RelatedPlace = struct {
    /// Position of the access point in World Geodetic System (WGS 84) format:
    /// [longitude, latitude].
    access_points: ?[]const AccessPoint,

    address: ?Address,

    /// The `PlaceId` of the place result.
    place_id: []const u8,

    /// A `PlaceType` is a category that the result place must belong to.
    place_type: PlaceType,

    /// The position in World Geodetic System (WGS 84) format: [longitude,
    /// latitude].
    position: ?[]const f64,

    /// The localized display name of this result item based on request parameter
    /// `language`.
    title: []const u8,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .address = "Address",
        .place_id = "PlaceId",
        .place_type = "PlaceType",
        .position = "Position",
        .title = "Title",
    };
};
