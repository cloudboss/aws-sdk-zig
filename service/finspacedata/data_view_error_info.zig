const ErrorCategory = @import("error_category.zig").ErrorCategory;

/// The structure with error messages.
pub const DataViewErrorInfo = struct {
    /// The category of the error.
    ///
    /// * `VALIDATION` – The inputs to this request are invalid.
    ///
    /// * `SERVICE_QUOTA_EXCEEDED` – Service quotas have been exceeded. Please
    /// contact AWS support to increase quotas.
    ///
    /// * `ACCESS_DENIED` – Missing required permission to perform this
    /// request.
    ///
    /// * `RESOURCE_NOT_FOUND` – One or more inputs to this request were not
    /// found.
    ///
    /// * `THROTTLING` – The system temporarily lacks sufficient resources to
    ///   process
    /// the request.
    ///
    /// * `INTERNAL_SERVICE_EXCEPTION` – An internal service error has
    /// occurred.
    ///
    /// * `CANCELLED` – Cancelled.
    ///
    /// * `USER_RECOVERABLE` – A user recoverable error has occurred.
    error_category: ?ErrorCategory = null,

    /// The text of the error message.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_category = "errorCategory",
        .error_message = "errorMessage",
    };
};
