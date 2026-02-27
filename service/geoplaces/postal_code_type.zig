pub const PostalCodeType = enum {
    usps_zip,
    usps_zip_plus_4,

    pub const json_field_names = .{
        .usps_zip = "USPS_ZIP",
        .usps_zip_plus_4 = "USPS_ZIP_PLUS_4",
    };
};
