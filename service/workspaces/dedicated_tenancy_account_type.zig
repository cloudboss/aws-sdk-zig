pub const DedicatedTenancyAccountType = enum {
    source_account,
    target_account,

    pub const json_field_names = .{
        .source_account = "SOURCE_ACCOUNT",
        .target_account = "TARGET_ACCOUNT",
    };
};
