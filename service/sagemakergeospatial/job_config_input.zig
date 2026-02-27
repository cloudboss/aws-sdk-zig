const BandMathConfigInput = @import("band_math_config_input.zig").BandMathConfigInput;
const CloudMaskingConfigInput = @import("cloud_masking_config_input.zig").CloudMaskingConfigInput;
const CloudRemovalConfigInput = @import("cloud_removal_config_input.zig").CloudRemovalConfigInput;
const GeoMosaicConfigInput = @import("geo_mosaic_config_input.zig").GeoMosaicConfigInput;
const LandCoverSegmentationConfigInput = @import("land_cover_segmentation_config_input.zig").LandCoverSegmentationConfigInput;
const ResamplingConfigInput = @import("resampling_config_input.zig").ResamplingConfigInput;
const StackConfigInput = @import("stack_config_input.zig").StackConfigInput;
const TemporalStatisticsConfigInput = @import("temporal_statistics_config_input.zig").TemporalStatisticsConfigInput;
const ZonalStatisticsConfigInput = @import("zonal_statistics_config_input.zig").ZonalStatisticsConfigInput;

/// The input structure for the JobConfig in an EarthObservationJob.
pub const JobConfigInput = union(enum) {
    /// An object containing information about the job configuration for BandMath.
    band_math_config: ?BandMathConfigInput,
    /// An object containing information about the job configuration for cloud
    /// masking.
    cloud_masking_config: ?CloudMaskingConfigInput,
    /// An object containing information about the job configuration for cloud
    /// removal.
    cloud_removal_config: ?CloudRemovalConfigInput,
    /// An object containing information about the job configuration for geomosaic.
    geo_mosaic_config: ?GeoMosaicConfigInput,
    /// An object containing information about the job configuration for land cover
    /// segmentation.
    land_cover_segmentation_config: ?LandCoverSegmentationConfigInput,
    /// An object containing information about the job configuration for resampling.
    resampling_config: ?ResamplingConfigInput,
    /// An object containing information about the job configuration for a Stacking
    /// Earth Observation job.
    stack_config: ?StackConfigInput,
    /// An object containing information about the job configuration for temporal
    /// statistics.
    temporal_statistics_config: ?TemporalStatisticsConfigInput,
    /// An object containing information about the job configuration for zonal
    /// statistics.
    zonal_statistics_config: ?ZonalStatisticsConfigInput,

    pub const json_field_names = .{
        .band_math_config = "BandMathConfig",
        .cloud_masking_config = "CloudMaskingConfig",
        .cloud_removal_config = "CloudRemovalConfig",
        .geo_mosaic_config = "GeoMosaicConfig",
        .land_cover_segmentation_config = "LandCoverSegmentationConfig",
        .resampling_config = "ResamplingConfig",
        .stack_config = "StackConfig",
        .temporal_statistics_config = "TemporalStatisticsConfig",
        .zonal_statistics_config = "ZonalStatisticsConfig",
    };
};
