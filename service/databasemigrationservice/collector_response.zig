const CollectorHealthCheck = @import("collector_health_check.zig").CollectorHealthCheck;
const InventoryData = @import("inventory_data.zig").InventoryData;
const VersionStatus = @import("version_status.zig").VersionStatus;

/// Describes a Fleet Advisor collector.
pub const CollectorResponse = struct {
    collector_health_check: ?CollectorHealthCheck = null,

    /// The name of the Fleet Advisor collector .
    collector_name: ?[]const u8 = null,

    /// The reference ID of the Fleet Advisor collector.
    collector_referenced_id: ?[]const u8 = null,

    /// The version of your Fleet Advisor collector, in semantic versioning format,
    /// for example
    /// `1.0.2`
    collector_version: ?[]const u8 = null,

    /// The timestamp when you created the collector, in the following format:
    /// `2022-01-24T19:04:02.596113Z`
    created_date: ?[]const u8 = null,

    /// A summary description of the Fleet Advisor collector.
    description: ?[]const u8 = null,

    inventory_data: ?InventoryData = null,

    /// The timestamp of the last time the collector received data, in the following
    /// format:
    /// `2022-01-24T19:04:02.596113Z`
    last_data_received: ?[]const u8 = null,

    /// The timestamp when DMS last modified the collector, in the following format:
    /// `2022-01-24T19:04:02.596113Z`
    modified_date: ?[]const u8 = null,

    /// The timestamp when DMS registered the collector, in the following format:
    /// `2022-01-24T19:04:02.596113Z`
    registered_date: ?[]const u8 = null,

    /// The Amazon S3 bucket that the Fleet Advisor collector uses to store
    /// inventory metadata.
    s3_bucket_name: ?[]const u8 = null,

    /// The IAM role that grants permissions to access the specified Amazon S3
    /// bucket.
    service_access_role_arn: ?[]const u8 = null,

    /// Whether the collector version is up to date.
    version_status: ?VersionStatus = null,

    pub const json_field_names = .{
        .collector_health_check = "CollectorHealthCheck",
        .collector_name = "CollectorName",
        .collector_referenced_id = "CollectorReferencedId",
        .collector_version = "CollectorVersion",
        .created_date = "CreatedDate",
        .description = "Description",
        .inventory_data = "InventoryData",
        .last_data_received = "LastDataReceived",
        .modified_date = "ModifiedDate",
        .registered_date = "RegisteredDate",
        .s3_bucket_name = "S3BucketName",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .version_status = "VersionStatus",
    };
};
