/// Contains a place suggestion resulting from a place suggestion query that is
/// run on a place index resource.
pub const SearchForSuggestionsResult = struct {
    /// The Amazon Location categories that describe the Place.
    ///
    /// For more information about using categories, including a list of Amazon
    /// Location categories, see [Categories and
    /// filtering](https://docs.aws.amazon.com/location/previous/developerguide/category-filtering.html), in the *Amazon Location Service developer guide*.
    categories: ?[]const []const u8 = null,

    /// The unique identifier of the Place. You can use this with the `GetPlace`
    /// operation to find the place again later, or to get full information for the
    /// Place.
    ///
    /// The `GetPlace` request must use the same `PlaceIndex` resource as the
    /// `SearchPlaceIndexForSuggestions` that generated the Place ID.
    ///
    /// For `SearchPlaceIndexForSuggestions` operations, the `PlaceId` is returned
    /// by place indexes that use Esri, Grab, or HERE as data providers.
    place_id: ?[]const u8 = null,

    /// Categories from the data provider that describe the Place that are not
    /// mapped to any Amazon Location categories.
    supplemental_categories: ?[]const []const u8 = null,

    /// The text of the place suggestion, typically formatted as an address string.
    text: []const u8,

    pub const json_field_names = .{
        .categories = "Categories",
        .place_id = "PlaceId",
        .supplemental_categories = "SupplementalCategories",
        .text = "Text",
    };
};
