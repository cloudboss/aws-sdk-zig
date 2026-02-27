const TemporalFilterSettings = @import("temporal_filter_settings.zig").TemporalFilterSettings;

/// Mpeg2 Filter Settings
pub const Mpeg2FilterSettings = struct {
    temporal_filter_settings: ?TemporalFilterSettings,

    pub const json_field_names = .{
        .temporal_filter_settings = "TemporalFilterSettings",
    };
};
