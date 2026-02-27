pub const PublicAclIgnoreBehavior = enum {
    ignored,
    not_ignored,

    pub const json_field_names = .{
        .ignored = "IGNORED",
        .not_ignored = "NOT_IGNORED",
    };
};
