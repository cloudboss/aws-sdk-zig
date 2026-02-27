const NoiseReducerFilter = @import("noise_reducer_filter.zig").NoiseReducerFilter;
const NoiseReducerFilterSettings = @import("noise_reducer_filter_settings.zig").NoiseReducerFilterSettings;
const NoiseReducerSpatialFilterSettings = @import("noise_reducer_spatial_filter_settings.zig").NoiseReducerSpatialFilterSettings;
const NoiseReducerTemporalFilterSettings = @import("noise_reducer_temporal_filter_settings.zig").NoiseReducerTemporalFilterSettings;

/// Enable the Noise reducer feature to remove noise from your video output if
/// necessary. Enable or disable this feature for each output individually. This
/// setting is disabled by default. When you enable Noise reducer, you must also
/// select a value for Noise reducer filter. For AVC outputs, when you include
/// Noise reducer, you cannot include the Bandwidth reduction filter.
pub const NoiseReducer = struct {
    /// Use Noise reducer filter to select one of the following spatial image
    /// filtering functions. To use this setting, you must also enable Noise
    /// reducer. * Bilateral preserves edges while reducing noise. * Mean (softest),
    /// Gaussian, Lanczos, and Sharpen (sharpest) do convolution filtering. *
    /// Conserve does min/max noise reduction. * Spatial does frequency-domain
    /// filtering based on JND principles. * Temporal optimizes video quality for
    /// complex motion.
    filter: ?NoiseReducerFilter,

    /// Settings for a noise reducer filter
    filter_settings: ?NoiseReducerFilterSettings,

    /// Noise reducer filter settings for spatial filter.
    spatial_filter_settings: ?NoiseReducerSpatialFilterSettings,

    /// Noise reducer filter settings for temporal filter.
    temporal_filter_settings: ?NoiseReducerTemporalFilterSettings,

    pub const json_field_names = .{
        .filter = "Filter",
        .filter_settings = "FilterSettings",
        .spatial_filter_settings = "SpatialFilterSettings",
        .temporal_filter_settings = "TemporalFilterSettings",
    };
};
