pub const ValidationExceptionType = enum {
    invalid_format,
    trimmed_data_access,
    expired_iterator,
    expired_next_token,

    pub const json_field_names = .{
        .invalid_format = "InvalidFormat",
        .trimmed_data_access = "TrimmedDataAccess",
        .expired_iterator = "ExpiredIterator",
        .expired_next_token = "ExpiredNextToken",
    };
};
