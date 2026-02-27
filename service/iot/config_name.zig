pub const ConfigName = enum {
    cert_age_threshold_in_days,
    cert_expiration_threshold_in_days,

    pub const json_field_names = .{
        .cert_age_threshold_in_days = "CERT_AGE_THRESHOLD_IN_DAYS",
        .cert_expiration_threshold_in_days = "CERT_EXPIRATION_THRESHOLD_IN_DAYS",
    };
};
