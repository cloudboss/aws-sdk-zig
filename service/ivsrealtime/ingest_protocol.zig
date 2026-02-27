pub const IngestProtocol = enum {
    rtmp,
    rtmps,

    pub const json_field_names = .{
        .rtmp = "RTMP",
        .rtmps = "RTMPS",
    };
};
