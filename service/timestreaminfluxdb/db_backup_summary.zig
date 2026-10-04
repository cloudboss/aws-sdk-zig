const ResourceDeploymentType = @import("resource_deployment_type.zig").ResourceDeploymentType;
const EngineType = @import("engine_type.zig").EngineType;
const DbBackupStatus = @import("db_backup_status.zig").DbBackupStatus;
const DbBackupType = @import("db_backup_type.zig").DbBackupType;

/// Contains a summary of a Timestream for InfluxDB backup.
pub const DbBackupSummary = struct {
    /// The Amazon Resource Name (ARN) of the backup.
    arn: []const u8,

    /// The time when the backup was created.
    created_at: ?i64 = null,

    /// The identifier of the DB resource that the backup was created from.
    db_resource_id: ?[]const u8 = null,

    /// The deployment type of the resource that the backup was created from.
    deployment_type: ?ResourceDeploymentType = null,

    /// The engine type of the resource that the backup was created from.
    engine_type: ?EngineType = null,

    /// The date after which the backup will be automatically deleted.
    expires_after: ?[]const u8 = null,

    /// Service-generated unique identifier of the backup.
    id: []const u8,

    /// The Amazon Web Services KMS key ARN used for encryption of the resource at
    /// the time of backup.
    kms_key_id: ?[]const u8 = null,

    /// The customer-provided name of the backup.
    name: ?[]const u8 = null,

    /// The status of the backup. Valid values are IN_PROGRESS, COMPLETED, FAILED,
    /// DELETING, and DELETED.
    status: ?DbBackupStatus = null,

    /// The type of backup. Valid values are HOURLY, DAILY, WEEKLY, MONTHLY,
    /// CUSTOM_SCHEDULE, ON_DEMAND, and CONTINUOUS.
    @"type": ?DbBackupType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .db_resource_id = "dbResourceId",
        .deployment_type = "deploymentType",
        .engine_type = "engineType",
        .expires_after = "expiresAfter",
        .id = "id",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};
