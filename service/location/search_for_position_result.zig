const Place = @import("place.zig").Place;

/// Contains a search result from a position search query that is run on a place
/// index resource.
pub const SearchForPositionResult = struct {
    /// The distance in meters of a great-circle arc between the query position and
    /// the result.
    ///
    /// A great-circle arc is the shortest path on a sphere, in this case the Earth.
    /// This returns the shortest distance between two locations.
    distance: f64,

    /// Details about the search result, such as its address and position.
    place: Place,

    /// The unique identifier of the place. You can use this with the `GetPlace`
    /// operation to find the place again later.
    ///
    /// For `SearchPlaceIndexForPosition` operations, the `PlaceId` is returned only
    /// by place indexes that use HERE or Grab as a data provider.
    place_id: ?[]const u8,

    pub const json_field_names = .{
        .distance = "Distance",
        .place = "Place",
        .place_id = "PlaceId",
    };
};
