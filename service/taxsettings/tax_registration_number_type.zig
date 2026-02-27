pub const TaxRegistrationNumberType = enum {
    tax_registration_number,
    local_registration_number,

    pub const json_field_names = .{
        .tax_registration_number = "TAX_REGISTRATION_NUMBER",
        .local_registration_number = "LOCAL_REGISTRATION_NUMBER",
    };
};
