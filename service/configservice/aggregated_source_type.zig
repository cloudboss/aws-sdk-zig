pub const AggregatedSourceType = enum {
    account,
    organization,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
    };
};
