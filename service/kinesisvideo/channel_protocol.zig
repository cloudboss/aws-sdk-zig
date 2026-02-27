pub const ChannelProtocol = enum {
    wss,
    https,
    webrtc,

    pub const json_field_names = .{
        .wss = "WSS",
        .https = "HTTPS",
        .webrtc = "WEBRTC",
    };
};
