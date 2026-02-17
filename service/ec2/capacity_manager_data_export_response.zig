const CapacityManagerDataExportStatus = @import("capacity_manager_data_export_status.zig").CapacityManagerDataExportStatus;
const OutputFormat = @import("output_format.zig").OutputFormat;
const Schedule = @import("schedule.zig").Schedule;
const Tag = @import("tag.zig").Tag;

/// Contains information about a Capacity Manager data export configuration,
/// including export settings, delivery status, and recent export activity.
pub const CapacityManagerDataExportResponse = struct {
    /// The unique identifier for the data export configuration.
    capacity_manager_data_export_id: ?[]const u8,

    /// The timestamp when the data export configuration was created.
    create_time: ?i64,

    /// The S3 URI of the most recently delivered export file.
    latest_delivery_s3_location_uri: ?[]const u8,

    /// The status of the most recent export delivery.
    latest_delivery_status: ?CapacityManagerDataExportStatus,

    /// A message describing the status of the most recent export delivery,
    /// including any error details if the delivery failed.
    latest_delivery_status_message: ?[]const u8,

    /// The timestamp when the most recent export was delivered to S3.
    latest_delivery_time: ?i64,

    /// The file format of the exported data.
    output_format: ?OutputFormat,

    /// The name of the S3 bucket where export files are delivered.
    s3_bucket_name: ?[]const u8,

    /// The S3 key prefix used for organizing export files within the bucket.
    s3_bucket_prefix: ?[]const u8,

    /// The frequency at which data exports are generated.
    schedule: ?Schedule,

    /// The tags associated with the data export configuration.
    tags: ?[]const Tag,
};
