pub const ParticipantType = enum {
    sender,
    receiver,

    pub const json_field_names = .{
        .sender = "SENDER",
        .receiver = "RECEIVER",
    };
};
