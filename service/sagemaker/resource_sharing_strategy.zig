pub const ResourceSharingStrategy = enum {
    lend,
    dontlend,
    lendandborrow,

    pub const json_field_names = .{
        .lend = "LEND",
        .dontlend = "DONTLEND",
        .lendandborrow = "LENDANDBORROW",
    };
};
