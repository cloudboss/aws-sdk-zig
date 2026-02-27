/// Ad marker for Apple HLS manifest.
pub const HlsAdMarkers = enum {
    elemental,
    elemental_scte35,

    pub const json_field_names = .{
        .elemental = "ELEMENTAL",
        .elemental_scte35 = "ELEMENTAL_SCTE35",
    };
};
