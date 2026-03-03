const AreaOfInterest = @import("area_of_interest.zig").AreaOfInterest;
const PropertyFilters = @import("property_filters.zig").PropertyFilters;
const TimeRangeFilterInput = @import("time_range_filter_input.zig").TimeRangeFilterInput;

/// The input structure for Raster Data Collection Query containing the Area of
/// Interest, TimeRange Filters, and Property Filters.
pub const RasterDataCollectionQueryInput = struct {
    /// The area of interest being queried for the raster data collection.
    area_of_interest: ?AreaOfInterest = null,

    /// The list of Property filters used in the Raster Data Collection Query.
    property_filters: ?PropertyFilters = null,

    /// The Amazon Resource Name (ARN) of the raster data collection.
    raster_data_collection_arn: []const u8,

    /// The TimeRange Filter used in the RasterDataCollection Query.
    time_range_filter: TimeRangeFilterInput,

    pub const json_field_names = .{
        .area_of_interest = "AreaOfInterest",
        .property_filters = "PropertyFilters",
        .raster_data_collection_arn = "RasterDataCollectionArn",
        .time_range_filter = "TimeRangeFilter",
    };
};
