pub const CacheConfigType = enum {
    amplify_managed,
    amplify_managed_no_cookies,

    pub const json_field_names = .{
        .amplify_managed = "AMPLIFY_MANAGED",
        .amplify_managed_no_cookies = "AMPLIFY_MANAGED_NO_COOKIES",
    };
};
