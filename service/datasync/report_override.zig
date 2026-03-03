const ReportLevel = @import("report_level.zig").ReportLevel;

/// Specifies the level of detail for a particular aspect of your DataSync
/// [task
/// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
pub const ReportOverride = struct {
    /// Specifies whether your task report includes errors only or successes and
    /// errors.
    ///
    /// For example, your report might mostly include only what didn't go well in
    /// your transfer
    /// (`ERRORS_ONLY`). At the same time, you want to verify that your [task
    /// filter](https://docs.aws.amazon.com/datasync/latest/userguide/filtering.html) is
    /// working correctly. In this situation, you can get a list of what files
    /// DataSync
    /// successfully skipped and if something transferred that you didn't to
    /// transfer
    /// (`SUCCESSES_AND_ERRORS`).
    report_level: ?ReportLevel = null,

    pub const json_field_names = .{
        .report_level = "ReportLevel",
    };
};
