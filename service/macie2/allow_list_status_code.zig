/// Indicates the current status of an allow list. Depending on the type of
/// criteria that the list specifies, possible values are:
pub const AllowListStatusCode = enum {
    ok,
    s3_object_not_found,
    s3_user_access_denied,
    s3_object_access_denied,
    s3_throttled,
    s3_object_oversize,
    s3_object_empty,
    unknown_error,

    pub const json_field_names = .{
        .ok = "OK",
        .s3_object_not_found = "S3_OBJECT_NOT_FOUND",
        .s3_user_access_denied = "S3_USER_ACCESS_DENIED",
        .s3_object_access_denied = "S3_OBJECT_ACCESS_DENIED",
        .s3_throttled = "S3_THROTTLED",
        .s3_object_oversize = "S3_OBJECT_OVERSIZE",
        .s3_object_empty = "S3_OBJECT_EMPTY",
        .unknown_error = "UNKNOWN_ERROR",
    };
};
