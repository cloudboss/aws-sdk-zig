const PackageVersionErrorCode = @import("package_version_error_code.zig").PackageVersionErrorCode;

/// l
/// An error associated with package.
pub const PackageVersionError = struct {
    /// The error code associated with the error. Valid error codes are:
    ///
    /// * `ALREADY_EXISTS`
    ///
    /// * `MISMATCHED_REVISION`
    ///
    /// * `MISMATCHED_STATUS`
    ///
    /// * `NOT_ALLOWED`
    ///
    /// * `NOT_FOUND`
    ///
    /// * `SKIPPED`
    error_code: ?PackageVersionErrorCode,

    /// The error message associated with the error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
