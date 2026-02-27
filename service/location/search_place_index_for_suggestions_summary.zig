/// A summary of the request sent by using `SearchPlaceIndexForSuggestions`.
pub const SearchPlaceIndexForSuggestionsSummary = struct {
    /// Contains the coordinates for the optional bias position specified in the
    /// request.
    ///
    /// This parameter contains a pair of numbers. The first number represents the X
    /// coordinate, or longitude; the second number represents the Y coordinate, or
    /// latitude.
    ///
    /// For example, `[-123.1174, 49.2847]` represents the position with longitude
    /// `-123.1174` and latitude `49.2847`.
    bias_position: ?[]const f64,

    /// The geospatial data provider attached to the place index resource specified
    /// in the request. Values can be one of the following:
    ///
    /// * Esri
    /// * Grab
    /// * Here
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// Contains the coordinates for the optional bounding box specified in the
    /// request.
    filter_b_box: ?[]const f64,

    /// The optional category filter specified in the request.
    filter_categories: ?[]const []const u8,

    /// Contains the optional country filter specified in the request.
    filter_countries: ?[]const []const u8,

    /// The preferred language used to return results. Matches the language in the
    /// request. The value is a valid [BCP 47](https://tools.ietf.org/search/bcp47)
    /// language tag, for example, `en` for English.
    language: ?[]const u8,

    /// Contains the optional result count limit specified in the request.
    max_results: ?i32,

    /// The free-form partial text input specified in the request.
    text: []const u8,

    pub const json_field_names = .{
        .bias_position = "BiasPosition",
        .data_source = "DataSource",
        .filter_b_box = "FilterBBox",
        .filter_categories = "FilterCategories",
        .filter_countries = "FilterCountries",
        .language = "Language",
        .max_results = "MaxResults",
        .text = "Text",
    };
};
