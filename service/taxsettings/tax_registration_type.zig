pub const TaxRegistrationType = enum {
    vat,
    gst,
    cpf,
    cnpj,
    sst,
    tin,
    nric,

    pub const json_field_names = .{
        .vat = "VAT",
        .gst = "GST",
        .cpf = "CPF",
        .cnpj = "CNPJ",
        .sst = "SST",
        .tin = "TIN",
        .nric = "NRIC",
    };
};
