/// Provides information about an Athena query error. The
/// `AthenaError` feature provides standardized error information to help you
/// understand failed queries and take steps after a query failure occurs.
/// `AthenaError` includes an `ErrorCategory` field that specifies
/// whether the cause of the failed query is due to system error, user error, or
/// other
/// error.
pub const AthenaError = struct {
    /// An integer value that specifies the category of a query failure error. The
    /// following
    /// list shows the category for each integer value.
    ///
    /// **1** - System
    ///
    /// **2** - User
    ///
    /// **3** - Other
    error_category: ?i32 = null,

    /// Contains a short description of the error that occurred.
    error_message: ?[]const u8 = null,

    /// An integer value that provides specific information about an Athena query
    /// error. For the meaning of specific values, see the [Error Type
    /// Reference](https://docs.aws.amazon.com/athena/latest/ug/error-reference.html#error-reference-error-type-reference) in the *Amazon Athena User
    /// Guide*.
    error_type: ?i32 = null,

    /// True if the query might succeed if resubmitted.
    retryable: bool = false,

    pub const json_field_names = .{
        .error_category = "ErrorCategory",
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
        .retryable = "Retryable",
    };
};
