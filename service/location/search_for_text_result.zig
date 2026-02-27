const Place = @import("place.zig").Place;

/// Contains a search result from a text search query that is run on a place
/// index resource.
pub const SearchForTextResult = struct {
    /// The distance in meters of a great-circle arc between the bias position
    /// specified and the result. `Distance` will be returned only if a bias
    /// position was specified in the query.
    ///
    /// A great-circle arc is the shortest path on a sphere, in this case the Earth.
    /// This returns the shortest distance between two locations.
    distance: ?f64,

    /// Details about the search result, such as its address and position.
    place: Place,

    /// The unique identifier of the place. You can use this with the `GetPlace`
    /// operation to find the place again later.
    ///
    /// For `SearchPlaceIndexForText` operations, the `PlaceId` is returned only by
    /// place indexes that use HERE or Grab as a data provider.
    place_id: ?[]const u8,

    /// The relative confidence in the match for a result among the results
    /// returned. For example, if more fields for an address match (including house
    /// number, street, city, country/region, and postal code), the relevance score
    /// is closer to 1.
    ///
    /// Returned only when the partner selected is Esri or Grab.
    relevance: ?f64,

    pub const json_field_names = .{
        .distance = "Distance",
        .place = "Place",
        .place_id = "PlaceId",
        .relevance = "Relevance",
    };
};
