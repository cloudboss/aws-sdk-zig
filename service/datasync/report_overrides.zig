const ReportOverride = @import("report_override.zig").ReportOverride;

/// The level of detail included in each aspect of your DataSync
/// [task
/// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
pub const ReportOverrides = struct {
    /// Specifies the level of reporting for the files, objects, and directories
    /// that DataSync attempted to delete in your destination location. This only
    /// applies if you [configure your
    /// task](https://docs.aws.amazon.com/datasync/latest/userguide/configure-metadata.html) to delete data in the destination that isn't in the source.
    deleted: ?ReportOverride = null,

    /// Specifies the level of reporting for the files, objects, and directories
    /// that DataSync attempted to skip during your transfer.
    skipped: ?ReportOverride = null,

    /// Specifies the level of reporting for the files, objects, and directories
    /// that DataSync attempted to transfer.
    transferred: ?ReportOverride = null,

    /// Specifies the level of reporting for the files, objects, and directories
    /// that DataSync attempted to verify at the end of your transfer.
    verified: ?ReportOverride = null,

    pub const json_field_names = .{
        .deleted = "Deleted",
        .skipped = "Skipped",
        .transferred = "Transferred",
        .verified = "Verified",
    };
};
