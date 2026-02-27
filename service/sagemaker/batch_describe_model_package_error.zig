/// The error code and error description associated with the resource.
pub const BatchDescribeModelPackageError = struct {
    error_code: []const u8,

    error_response: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_response = "ErrorResponse",
    };
};
