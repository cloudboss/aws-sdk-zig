const aws = @import("aws");

const AccessPointStatus = @import("access_point_status.zig").AccessPointStatus;

/// Contains metadata about a backup access point.
pub const ListAccessPointsMember = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the backup access
    /// point.
    access_point_arn: []const u8,

    /// Metadata for the backup access point. After the backup access point reaches
    /// the `AVAILABLE`
    /// status, this map contains `S3AccessPointArn` and `S3AccessPointAlias`, which
    /// you use with
    /// standard Amazon S3 read APIs to access the backup data. For continuous
    /// recovery points, this map also
    /// contains `AccessPointInTime` (in format `2021-11-27T03:30:27Z`). The access
    /// point
    /// provides access to the content present in the backup at that specific time.
    access_point_metadata: []const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the backup vault that contains the
    /// recovery point.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of the backup vault that contains the recovery point.
    backup_vault_name: []const u8,

    /// The date and time that the backup access point was created, in Unix format
    /// and Coordinated Universal Time
    /// (UTC). The value of `CreationTime` is accurate to milliseconds. For example,
    /// the value
    /// 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    creation_time: i64,

    /// The name of the backup access point.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the recovery point that the backup access
    /// point provides access to.
    recovery_point_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the resource that was backed up, such as
    /// an Amazon S3 bucket.
    resource_arn: []const u8,

    /// The type of Amazon Web Services resource associated with the recovery point.
    /// For example, `S3` for
    /// Amazon Simple Storage Service.
    resource_type: []const u8,

    /// The current status of the backup access point.
    status: AccessPointStatus,

    /// A message that provides additional detail about the status of the backup
    /// access point, such as the reason a
    /// creation or deletion attempt failed.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .access_point_metadata = "AccessPointMetadata",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .name = "Name",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
