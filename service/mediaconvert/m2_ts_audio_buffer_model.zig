/// Selects between the DVB and ATSC buffer models for Dolby Digital audio.
pub const M2tsAudioBufferModel = enum {
    dvb,
    atsc,

    pub const json_field_names = .{
        .dvb = "DVB",
        .atsc = "ATSC",
    };
};
