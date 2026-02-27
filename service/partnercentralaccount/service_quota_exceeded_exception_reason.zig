pub const ServiceQuotaExceededExceptionReason = enum {
    limit_exceeded_number_of_email,
    limit_exceeded_number_of_domain,

    pub const json_field_names = .{
        .limit_exceeded_number_of_email = "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
        .limit_exceeded_number_of_domain = "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
    };
};
