const AttachedFileInvalidRequestExceptionReason = @import("attached_file_invalid_request_exception_reason.zig").AttachedFileInvalidRequestExceptionReason;

/// Reason why the request was invalid.
pub const InvalidRequestExceptionReason = union(enum) {
    /// Reason why the StartAttachedFiledUpload request was invalid.
    attached_file_invalid_request_exception_reason: ?AttachedFileInvalidRequestExceptionReason,

    pub const json_field_names = .{
        .attached_file_invalid_request_exception_reason = "AttachedFileInvalidRequestExceptionReason",
    };
};
