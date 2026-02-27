/// M2ts Audio Buffer Model
pub const M2tsAudioBufferModel = enum {
    atsc,
    dvb,

    pub const json_field_names = .{
        .atsc = "ATSC",
        .dvb = "DVB",
    };
};
