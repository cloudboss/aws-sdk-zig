pub const MediaCapabilities = enum {
    send_receive,
    send,
    receive,
    none,

    pub const json_field_names = .{
        .send_receive = "SEND_RECEIVE",
        .send = "SEND",
        .receive = "RECEIVE",
        .none = "NONE",
    };
};
