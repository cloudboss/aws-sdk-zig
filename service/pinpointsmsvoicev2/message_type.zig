pub const MessageType = enum {
    transactional,
    promotional,

    pub const json_field_names = .{
        .transactional = "TRANSACTIONAL",
        .promotional = "PROMOTIONAL",
    };
};
