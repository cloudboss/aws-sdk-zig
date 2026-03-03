const ReportExportConfig = @import("report_export_config.zig").ReportExportConfig;
const ReportGroupStatusType = @import("report_group_status_type.zig").ReportGroupStatusType;
const Tag = @import("tag.zig").Tag;
const ReportType = @import("report_type.zig").ReportType;

/// A series of reports. Each report contains information about the results from
/// running a
/// series of test cases. You specify the test cases for a report group in the
/// buildspec for
/// a build project using one or more paths to the test case files.
pub const ReportGroup = struct {
    /// The ARN of the `ReportGroup`.
    arn: ?[]const u8 = null,

    /// The date and time this `ReportGroup` was created.
    created: ?i64 = null,

    /// Information about the destination where the raw data of this `ReportGroup`
    /// is exported.
    export_config: ?ReportExportConfig = null,

    /// The date and time this `ReportGroup` was last modified.
    last_modified: ?i64 = null,

    /// The name of the `ReportGroup`.
    name: ?[]const u8 = null,

    /// The status of the report group. This property is read-only.
    ///
    /// This can be one of the following values:
    ///
    /// **ACTIVE**
    ///
    /// The report group is active.
    ///
    /// **DELETING**
    ///
    /// The report group is in the process of being deleted.
    status: ?ReportGroupStatusType = null,

    /// A list of tag key and value pairs associated with this report group.
    ///
    /// These tags are available for use by Amazon Web Services services that
    /// support CodeBuild report group
    /// tags.
    tags: ?[]const Tag = null,

    /// The type of the `ReportGroup`. This can be one of the following
    /// values:
    ///
    /// **CODE_COVERAGE**
    ///
    /// The report group contains code coverage reports.
    ///
    /// **TEST**
    ///
    /// The report group contains test reports.
    @"type": ?ReportType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created = "created",
        .export_config = "exportConfig",
        .last_modified = "lastModified",
        .name = "name",
        .status = "status",
        .tags = "tags",
        .@"type" = "type",
    };
};
