const M2tsSettings = @import("m2_ts_settings.zig").M2tsSettings;

/// Udp Container Settings
pub const UdpContainerSettings = struct {
    m2_ts_settings: ?M2tsSettings,

    pub const json_field_names = .{
        .m2_ts_settings = "M2tsSettings",
    };
};
