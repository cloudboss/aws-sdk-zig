const AggregatedSourceStatusType = @import("aggregated_source_status_type.zig").AggregatedSourceStatusType;
const AggregatedSourceType = @import("aggregated_source_type.zig").AggregatedSourceType;

/// The current sync status between the source and the aggregator
/// account.
pub const AggregatedSourceStatus = struct {
    /// The region authorized to collect aggregated data.
    aws_region: ?[]const u8,

    /// The error code that Config returned when the source account
    /// aggregation last failed.
    last_error_code: ?[]const u8,

    /// The message indicating that the source account aggregation
    /// failed due to an error.
    last_error_message: ?[]const u8,

    /// Filters the last updated status type.
    ///
    /// * Valid value FAILED indicates errors while moving
    /// data.
    ///
    /// * Valid value SUCCEEDED indicates the data was
    /// successfully moved.
    ///
    /// * Valid value OUTDATED indicates the data is not the most
    /// recent.
    last_update_status: ?AggregatedSourceStatusType,

    /// The time of the last update.
    last_update_time: ?i64,

    /// The source account ID or an organization.
    source_id: ?[]const u8,

    /// The source account or an organization.
    source_type: ?AggregatedSourceType,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .last_error_code = "LastErrorCode",
        .last_error_message = "LastErrorMessage",
        .last_update_status = "LastUpdateStatus",
        .last_update_time = "LastUpdateTime",
        .source_id = "SourceId",
        .source_type = "SourceType",
    };
};
