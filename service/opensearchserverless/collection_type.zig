pub const CollectionType = enum {
    /// Search collection type
    search,
    /// Timeseries collection type
    timeseries,
    /// Vectorsearch collection type
    vectorsearch,

    pub const json_field_names = .{
        .search = "SEARCH",
        .timeseries = "TIMESERIES",
        .vectorsearch = "VECTORSEARCH",
    };
};
