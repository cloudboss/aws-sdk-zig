const AttachedFileServiceQuotaExceededExceptionReason = @import("attached_file_service_quota_exceeded_exception_reason.zig").AttachedFileServiceQuotaExceededExceptionReason;

/// The reason for the exception.
pub const ServiceQuotaExceededExceptionReason = union(enum) {
    /// Total file size of all files or total number of files exceeds the service
    /// quota
    attached_file_service_quota_exceeded_exception_reason: ?AttachedFileServiceQuotaExceededExceptionReason,

    pub const json_field_names = .{
        .attached_file_service_quota_exceeded_exception_reason = "AttachedFileServiceQuotaExceededExceptionReason",
    };
};
