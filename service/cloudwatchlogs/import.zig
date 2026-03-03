const ImportFilter = @import("import_filter.zig").ImportFilter;
const ImportStatistics = @import("import_statistics.zig").ImportStatistics;
const ImportStatus = @import("import_status.zig").ImportStatus;

/// An import job to move data from CloudTrail Event Data Store to CloudWatch.
pub const Import = struct {
    /// The timestamp when the import task was created, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    creation_time: ?i64 = null,

    /// Error message related to any failed imports
    error_message: ?[]const u8 = null,

    /// The ARN of the managed CloudWatch Logs log group where the events are being
    /// imported to.
    import_destination_arn: ?[]const u8 = null,

    /// The filter criteria used for this import task.
    import_filter: ?ImportFilter = null,

    /// The unique identifier of the import task.
    import_id: ?[]const u8 = null,

    /// The ARN of the CloudTrail Lake Event Data Store being imported from.
    import_source_arn: ?[]const u8 = null,

    /// Statistics about the import progress
    import_statistics: ?ImportStatistics = null,

    /// The current status of the import task. Valid values are IN_PROGRESS,
    /// CANCELLED, COMPLETED and FAILED.
    import_status: ?ImportStatus = null,

    /// The timestamp when the import task was last updated, expressed as the number
    /// of milliseconds after Jan 1, 1970 00:00:00 UTC.
    last_updated_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .error_message = "errorMessage",
        .import_destination_arn = "importDestinationArn",
        .import_filter = "importFilter",
        .import_id = "importId",
        .import_source_arn = "importSourceArn",
        .import_statistics = "importStatistics",
        .import_status = "importStatus",
        .last_updated_time = "lastUpdatedTime",
    };
};
