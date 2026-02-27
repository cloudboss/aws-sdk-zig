pub const ChatEventType = enum {
    disconnect,
    message,
    event,

    pub const json_field_names = .{
        .disconnect = "DISCONNECT",
        .message = "MESSAGE",
        .event = "EVENT",
    };
};
