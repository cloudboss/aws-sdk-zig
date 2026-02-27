/// A summary of the request sent by using `SearchPlaceIndexForPosition`.
pub const SearchPlaceIndexForPositionSummary = struct {
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

    /// The preferred language used to return results. Matches the language in the
    /// request. The value is a valid [BCP 47](https://tools.ietf.org/search/bcp47)
    /// language tag, for example, `en` for English.
    language: ?[]const u8,

    /// Contains the optional result count limit that is specified in the request.
    ///
    /// Default value: `50`
    max_results: ?i32,

    /// The position specified in the request.
    position: []const f64,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .language = "Language",
        .max_results = "MaxResults",
        .position = "Position",
    };
};
