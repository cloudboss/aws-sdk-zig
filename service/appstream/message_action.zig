pub const MessageAction = enum {
    suppress,
    resend,

    pub const json_field_names = .{
        .suppress = "SUPPRESS",
        .resend = "RESEND",
    };
};
