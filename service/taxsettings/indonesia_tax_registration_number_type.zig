pub const IndonesiaTaxRegistrationNumberType = enum {
    nik,
    passport_number,
    npwp,
    nitku,

    pub const json_field_names = .{
        .nik = "NIK",
        .passport_number = "PASSPORT_NUMBER",
        .npwp = "NPWP",
        .nitku = "NITKU",
    };
};
