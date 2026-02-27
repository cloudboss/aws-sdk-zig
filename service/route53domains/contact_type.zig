pub const ContactType = enum {
    person,
    company,
    association,
    public_body,
    reseller,

    pub const json_field_names = .{
        .person = "PERSON",
        .company = "COMPANY",
        .association = "ASSOCIATION",
        .public_body = "PUBLIC_BODY",
        .reseller = "RESELLER",
    };
};
