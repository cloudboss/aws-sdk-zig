const MapMatchingConfig = @import("map_matching_config.zig").MapMatchingConfig;
const ReverseGeocodingConfig = @import("reverse_geocoding_config.zig").ReverseGeocodingConfig;

/// It contains configs such as ReverseGeocodingConfig and MapMatchingConfig.
pub const VectorEnrichmentJobConfig = union(enum) {
    /// The input structure for Map Matching operation type.
    map_matching_config: ?MapMatchingConfig,
    /// The input structure for Reverse Geocoding operation type.
    reverse_geocoding_config: ?ReverseGeocodingConfig,

    pub const json_field_names = .{
        .map_matching_config = "MapMatchingConfig",
        .reverse_geocoding_config = "ReverseGeocodingConfig",
    };
};
