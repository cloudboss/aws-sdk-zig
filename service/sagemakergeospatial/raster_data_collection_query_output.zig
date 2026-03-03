const AreaOfInterest = @import("area_of_interest.zig").AreaOfInterest;
const PropertyFilters = @import("property_filters.zig").PropertyFilters;
const TimeRangeFilterOutput = @import("time_range_filter_output.zig").TimeRangeFilterOutput;

/// The output structure contains the Raster Data Collection Query
/// input along with some additional metadata.
pub const RasterDataCollectionQueryOutput = struct {
    /// The Area of Interest used in the search.
    area_of_interest: ?AreaOfInterest = null,

    /// Property filters used in the search.
    property_filters: ?PropertyFilters = null,

    /// The ARN of the Raster Data Collection against which the search is done.
    raster_data_collection_arn: []const u8,

    /// The name of the raster data collection.
    raster_data_collection_name: []const u8,

    /// The TimeRange filter used in the search.
    time_range_filter: TimeRangeFilterOutput,

    pub const json_field_names = .{
        .area_of_interest = "AreaOfInterest",
        .property_filters = "PropertyFilters",
        .raster_data_collection_arn = "RasterDataCollectionArn",
        .raster_data_collection_name = "RasterDataCollectionName",
        .time_range_filter = "TimeRangeFilter",
    };
};
