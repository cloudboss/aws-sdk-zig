const CacheReportStatus = @import("cache_report_status.zig").CacheReportStatus;
const CacheReportFilter = @import("cache_report_filter.zig").CacheReportFilter;
const Tag = @import("tag.zig").Tag;

/// Contains all informational fields associated with a cache report. Includes
/// name, ARN,
/// tags, status, progress, filters, start time, and end time.
pub const CacheReportInfo = struct {
    /// The Amazon Resource Name (ARN) of the cache report you want to describe.
    cache_report_arn: ?[]const u8,

    /// The status of the specified cache report.
    cache_report_status: ?CacheReportStatus,

    /// The time at which the gateway stopped generating the cache report.
    end_time: ?i64,

    /// The list of filters and parameters that determine which files are excluded
    /// from the
    /// report.
    exclusion_filters: ?[]const CacheReportFilter,

    file_share_arn: ?[]const u8,

    /// The list of filters and parameters that determine which files are included
    /// in the
    /// report.
    inclusion_filters: ?[]const CacheReportFilter,

    /// The ARN of the Amazon S3 bucket location where the cache report is saved.
    location_arn: ?[]const u8,

    /// The percentage of the report generation process that has been completed at
    /// time of
    /// inquiry.
    report_completion_percent: ?i32,

    /// The file name of the completed cache report object stored in Amazon S3.
    report_name: ?[]const u8,

    role: ?[]const u8,

    /// The time at which the gateway started generating the cache report.
    start_time: ?i64,

    /// The list of key/value tags associated with the report.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .cache_report_arn = "CacheReportARN",
        .cache_report_status = "CacheReportStatus",
        .end_time = "EndTime",
        .exclusion_filters = "ExclusionFilters",
        .file_share_arn = "FileShareARN",
        .inclusion_filters = "InclusionFilters",
        .location_arn = "LocationARN",
        .report_completion_percent = "ReportCompletionPercent",
        .report_name = "ReportName",
        .role = "Role",
        .start_time = "StartTime",
        .tags = "Tags",
    };
};
