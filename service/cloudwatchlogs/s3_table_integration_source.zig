const DataSource = @import("data_source.zig").DataSource;
const S3TableIntegrationSourceStatus = @import("s3_table_integration_source_status.zig").S3TableIntegrationSourceStatus;

/// Represents a data source association with an S3 Table Integration, including
/// its status
/// and metadata.
pub const S3TableIntegrationSource = struct {
    /// The timestamp when the data source association was created.
    created_time_stamp: ?i64 = null,

    /// The data source associated with the S3 Table Integration.
    data_source: ?DataSource = null,

    /// The unique identifier for this data source association.
    identifier: ?[]const u8 = null,

    /// The current status of the data source association.
    status: ?S3TableIntegrationSourceStatus = null,

    /// Additional information about the status of the data source association.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_time_stamp = "createdTimeStamp",
        .data_source = "dataSource",
        .identifier = "identifier",
        .status = "status",
        .status_reason = "statusReason",
    };
};
