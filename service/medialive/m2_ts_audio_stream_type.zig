/// M2ts Audio Stream Type
pub const M2tsAudioStreamType = enum {
    atsc,
    dvb,

    pub const json_field_names = .{
        .atsc = "ATSC",
        .dvb = "DVB",
    };
};
