pub const ContributorInsightsAction = enum {
    enable,
    disable,

    pub const json_field_names = .{
        .enable = "ENABLE",
        .disable = "DISABLE",
    };
};
