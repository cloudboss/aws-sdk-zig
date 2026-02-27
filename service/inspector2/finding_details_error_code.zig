pub const FindingDetailsErrorCode = enum {
    internal_error,
    access_denied,
    finding_details_not_found,
    invalid_input,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
        .finding_details_not_found = "FINDING_DETAILS_NOT_FOUND",
        .invalid_input = "INVALID_INPUT",
    };
};
