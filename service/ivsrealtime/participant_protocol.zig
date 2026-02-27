pub const ParticipantProtocol = enum {
    unknown,
    whip,
    rtmp,
    rtmps,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .whip = "WHIP",
        .rtmp = "RTMP",
        .rtmps = "RTMPS",
    };
};
