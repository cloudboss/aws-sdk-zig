pub const SupplementalTaxRegistrationType = enum {
    vat,

    pub const json_field_names = .{
        .vat = "VAT",
    };
};
