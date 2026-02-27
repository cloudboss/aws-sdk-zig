pub const PrivateDnsPreference = enum {
    verified_domains_only,
    all_domains,
    verified_domains_and_specified_domains,
    specified_domains_only,

    pub const json_field_names = .{
        .verified_domains_only = "VERIFIED_DOMAINS_ONLY",
        .all_domains = "ALL_DOMAINS",
        .verified_domains_and_specified_domains = "VERIFIED_DOMAINS_AND_SPECIFIED_DOMAINS",
        .specified_domains_only = "SPECIFIED_DOMAINS_ONLY",
    };
};
