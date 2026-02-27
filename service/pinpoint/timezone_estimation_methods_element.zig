pub const __TimezoneEstimationMethodsElement = enum {
    phone_number,
    postal_code,

    pub const json_field_names = .{
        .phone_number = "PHONE_NUMBER",
        .postal_code = "POSTAL_CODE",
    };
};
