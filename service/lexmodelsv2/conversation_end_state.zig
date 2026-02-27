pub const ConversationEndState = enum {
    success,
    failure,
    dropped,

    pub const json_field_names = .{
        .success = "Success",
        .failure = "Failure",
        .dropped = "Dropped",
    };
};
