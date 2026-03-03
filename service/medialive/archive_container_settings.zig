const M2tsSettings = @import("m2_ts_settings.zig").M2tsSettings;
const RawSettings = @import("raw_settings.zig").RawSettings;

/// Archive Container Settings
pub const ArchiveContainerSettings = struct {
    m2_ts_settings: ?M2tsSettings = null,

    raw_settings: ?RawSettings = null,

    pub const json_field_names = .{
        .m2_ts_settings = "M2tsSettings",
        .raw_settings = "RawSettings",
    };
};
