pub const AccountScope = enum {
    payer,
    linked,

    pub const json_field_names = .{
        .payer = "PAYER",
        .linked = "LINKED",
    };
};
