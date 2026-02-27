pub const MailFrom = enum {
    replace,
    preserve,

    pub const json_field_names = .{
        .replace = "REPLACE",
        .preserve = "PRESERVE",
    };
};
