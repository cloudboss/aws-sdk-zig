const MultiplexM2tsSettings = @import("multiplex_m2_ts_settings.zig").MultiplexM2tsSettings;

/// Multiplex Container Settings
pub const MultiplexContainerSettings = struct {
    multiplex_m2_ts_settings: ?MultiplexM2tsSettings = null,

    pub const json_field_names = .{
        .multiplex_m2_ts_settings = "MultiplexM2tsSettings",
    };
};
