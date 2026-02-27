pub const ActionType = enum {
    publish,
    subscribe,
    receive,
    connect,

    pub const json_field_names = .{
        .publish = "PUBLISH",
        .subscribe = "SUBSCRIBE",
        .receive = "RECEIVE",
        .connect = "CONNECT",
    };
};
