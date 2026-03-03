const AlgorithmNameGeoMosaic = @import("algorithm_name_geo_mosaic.zig").AlgorithmNameGeoMosaic;

/// Input configuration information for the geomosaic.
pub const GeoMosaicConfigInput = struct {
    /// The name of the algorithm being used for geomosaic.
    algorithm_name: ?AlgorithmNameGeoMosaic = null,

    /// The target bands for geomosaic.
    target_bands: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .target_bands = "TargetBands",
    };
};
