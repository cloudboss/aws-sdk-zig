pub const AllowedUserAction = enum {
    call,
    discard,

    pub const json_field_names = .{
        .call = "CALL",
        .discard = "DISCARD",
    };
};
