pub const Sector = enum {
    business,
    individual,
    public_institutions,

    pub const json_field_names = .{
        .business = "BUSINESS",
        .individual = "INDIVIDUAL",
        .public_institutions = "PUBLIC_INSTITUTIONS",
    };
};
