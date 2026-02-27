pub const rs = enum {
    single_region,
    multi_region,

    pub const json_field_names = .{
        .single_region = "SINGLE_REGION",
        .multi_region = "MULTI_REGION",
    };
};
