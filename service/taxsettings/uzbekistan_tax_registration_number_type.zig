pub const UzbekistanTaxRegistrationNumberType = enum {
    business,
    individual,

    pub const json_field_names = .{
        .business = "BUSINESS",
        .individual = "INDIVIDUAL",
    };
};
