pub const NniPartnerType = enum {
    v1,
    v2,
    non_partner,

    pub const json_field_names = .{
        .v1 = "V1",
        .v2 = "V2",
        .non_partner = "NonPartner",
    };
};
