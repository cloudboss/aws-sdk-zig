pub const ParticipantTokenCapability = enum {
    publish,
    subscribe,

    pub const json_field_names = .{
        .publish = "PUBLISH",
        .subscribe = "SUBSCRIBE",
    };
};
