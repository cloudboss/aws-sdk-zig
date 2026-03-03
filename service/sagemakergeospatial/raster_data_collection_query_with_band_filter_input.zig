const AreaOfInterest = @import("area_of_interest.zig").AreaOfInterest;
const PropertyFilters = @import("property_filters.zig").PropertyFilters;
const TimeRangeFilterInput = @import("time_range_filter_input.zig").TimeRangeFilterInput;

/// This is a RasterDataCollectionQueryInput containing AreaOfInterest, Time
/// Range filter and Property filters.
pub const RasterDataCollectionQueryWithBandFilterInput = struct {
    /// The Area of interest to be used in the search query.
    area_of_interest: ?AreaOfInterest = null,

    /// The list of Bands to be displayed in the result for each item.
    band_filter: ?[]const []const u8 = null,

    /// The Property Filters used in the search query.
    property_filters: ?PropertyFilters = null,

    /// The TimeRange Filter used in the search query.
    time_range_filter: TimeRangeFilterInput,

    pub const json_field_names = .{
        .area_of_interest = "AreaOfInterest",
        .band_filter = "BandFilter",
        .property_filters = "PropertyFilters",
        .time_range_filter = "TimeRangeFilter",
    };
};
