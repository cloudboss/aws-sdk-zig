pub const CustomerType = enum {
    standalone,
    organization,

    pub const json_field_names = .{
        .standalone = "STANDALONE",
        .organization = "ORGANIZATION",
    };
};
