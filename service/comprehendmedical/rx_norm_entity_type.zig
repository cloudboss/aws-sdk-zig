pub const RxNormEntityType = enum {
    brand_name,
    generic_name,

    pub const json_field_names = .{
        .brand_name = "BRAND_NAME",
        .generic_name = "GENERIC_NAME",
    };
};
