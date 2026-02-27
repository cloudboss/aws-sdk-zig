pub const FailedItemErrorCode = enum {
    invalid_arn,
    duplicate_arn,
    item_does_not_exist,
    access_denied,
    limit_exceeded,
    internal_error,

    pub const json_field_names = .{
        .invalid_arn = "INVALID_ARN",
        .duplicate_arn = "DUPLICATE_ARN",
        .item_does_not_exist = "ITEM_DOES_NOT_EXIST",
        .access_denied = "ACCESS_DENIED",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
    };
};
