const ErrorCode = @import("error_code.zig").ErrorCode;

/// An error that explains why an action did not succeed.
pub const ErrorReason = struct {
    /// Service Quotas returns the following error values:
    ///
    /// * `DEPENDENCY_ACCESS_DENIED_ERROR` - The caller does not have the
    /// required permissions to complete the action. To resolve the error, you must
    /// have
    /// permission to access the Amazon Web Services service or quota.
    ///
    /// * `DEPENDENCY_THROTTLING_ERROR` - The Amazon Web Services service is
    ///   throttling
    /// Service Quotas.
    ///
    /// * `DEPENDENCY_SERVICE_ERROR` - The Amazon Web Services service is not
    /// available.
    ///
    /// * `SERVICE_QUOTA_NOT_AVAILABLE_ERROR` - There was an error in
    /// Service Quotas.
    error_code: ?ErrorCode = null,

    /// The error message.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
