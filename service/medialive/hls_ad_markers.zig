/// Hls Ad Markers
pub const HlsAdMarkers = enum {
    adobe,
    elemental,
    elemental_scte35,

    pub const json_field_names = .{
        .adobe = "ADOBE",
        .elemental = "ELEMENTAL",
        .elemental_scte35 = "ELEMENTAL_SCTE35",
    };
};
