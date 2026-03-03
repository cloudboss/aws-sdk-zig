const BandwidthReductionFilterSettings = @import("bandwidth_reduction_filter_settings.zig").BandwidthReductionFilterSettings;
const TemporalFilterSettings = @import("temporal_filter_settings.zig").TemporalFilterSettings;

/// H265 Filter Settings
pub const H265FilterSettings = struct {
    bandwidth_reduction_filter_settings: ?BandwidthReductionFilterSettings = null,

    temporal_filter_settings: ?TemporalFilterSettings = null,

    pub const json_field_names = .{
        .bandwidth_reduction_filter_settings = "BandwidthReductionFilterSettings",
        .temporal_filter_settings = "TemporalFilterSettings",
    };
};
