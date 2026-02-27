pub const SaudiArabiaTaxRegistrationNumberType = enum {
    tax_registration_number,
    tax_identification_number,
    commercial_registration_number,

    pub const json_field_names = .{
        .tax_registration_number = "TAX_REGISTRATION_NUMBER",
        .tax_identification_number = "TAX_IDENTIFICATION_NUMBER",
        .commercial_registration_number = "COMMERCIAL_REGISTRATION_NUMBER",
    };
};
