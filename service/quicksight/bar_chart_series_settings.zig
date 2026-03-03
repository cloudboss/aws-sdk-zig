const BorderSettings = @import("border_settings.zig").BorderSettings;
const DecalSettings = @import("decal_settings.zig").DecalSettings;

/// Options that determine the presentation of a bar series in the visual.
pub const BarChartSeriesSettings = struct {
    /// Border settings for the bar series.
    border_settings: ?BorderSettings = null,

    /// Decal settings for the bar series.
    decal_settings: ?DecalSettings = null,

    pub const json_field_names = .{
        .border_settings = "BorderSettings",
        .decal_settings = "DecalSettings",
    };
};
