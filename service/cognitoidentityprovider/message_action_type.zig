pub const MessageActionType = enum {
    resend,
    suppress,

    pub const json_field_names = .{
        .resend = "RESEND",
        .suppress = "SUPPRESS",
    };
};
