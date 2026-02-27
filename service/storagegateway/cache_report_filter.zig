const CacheReportFilterName = @import("cache_report_filter_name.zig").CacheReportFilterName;

/// A list of filter parameters and associated values that determine which files
/// are
/// included or excluded from a cache report created by a `StartCacheReport`
/// request. Multiple instances of the same filter parameter are combined with
/// an OR operation,
/// while different parameters are combined with an AND operation.
pub const CacheReportFilter = struct {
    /// The parameter name for a filter that determines which files are included or
    /// excluded
    /// from a cache report.
    ///
    /// **Valid Names:**
    ///
    /// UploadFailureReason | UploadState
    name: CacheReportFilterName,

    /// The parameter value for a filter that determines which files are included or
    /// excluded
    /// from a cache report.
    ///
    /// **Valid `UploadFailureReason` Values:**
    ///
    /// `InaccessibleStorageClass` | `InvalidObjectState` |
    /// `ObjectMissing` | `S3AccessDenied`
    ///
    /// **Valid `UploadState` Values:**
    ///
    /// `FailingUpload`
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
