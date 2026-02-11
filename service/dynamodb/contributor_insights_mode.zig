pub const ContributorInsightsMode = enum {
    accessed_and_throttled_keys,
    throttled_keys,

    pub const json_field_names = .{
        .accessed_and_throttled_keys = "ACCESSED_AND_THROTTLED_KEYS",
        .throttled_keys = "THROTTLED_KEYS",
    };
};
