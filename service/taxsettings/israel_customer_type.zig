pub const IsraelCustomerType = enum {
    business,
    individual,

    pub const json_field_names = .{
        .business = "BUSINESS",
        .individual = "INDIVIDUAL",
    };
};
