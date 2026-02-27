pub const MessageType = enum {
    splice_insert,
    time_signal,

    pub const json_field_names = .{
        .splice_insert = "SPLICE_INSERT",
        .time_signal = "TIME_SIGNAL",
    };
};
