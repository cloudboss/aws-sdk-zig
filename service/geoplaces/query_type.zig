pub const QueryType = enum {
    category,
    business_chain,

    pub const json_field_names = .{
        .category = "CATEGORY",
        .business_chain = "BUSINESS_CHAIN",
    };
};
