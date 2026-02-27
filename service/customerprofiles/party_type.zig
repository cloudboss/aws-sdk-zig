pub const PartyType = enum {
    individual,
    business,
    other,

    pub const json_field_names = .{
        .individual = "INDIVIDUAL",
        .business = "BUSINESS",
        .other = "OTHER",
    };
};
