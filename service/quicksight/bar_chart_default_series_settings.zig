const BorderSettings = @import("border_settings.zig").BorderSettings;
const DecalSettings = @import("decal_settings.zig").DecalSettings;

/// The options that determine the default presentation of all bar series in
/// `BarChartVisual`.
pub const BarChartDefaultSeriesSettings = struct {
    /// Border settings for all bar series in the visual.
    border_settings: ?BorderSettings,

    /// Decal settings for all bar series in the visual.
    decal_settings: ?DecalSettings,

    pub const json_field_names = .{
        .border_settings = "BorderSettings",
        .decal_settings = "DecalSettings",
    };
};
