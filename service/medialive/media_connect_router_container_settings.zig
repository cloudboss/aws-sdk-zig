const M2tsSettings = @import("m2_ts_settings.zig").M2tsSettings;

/// Media Connect Router Container Settings
pub const MediaConnectRouterContainerSettings = struct {
    m2_ts_settings: ?M2tsSettings = null,

    pub const json_field_names = .{
        .m2_ts_settings = "M2tsSettings",
    };
};
