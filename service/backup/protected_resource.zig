/// A structure that contains information about a backed-up resource.
pub const ProtectedResource = struct {
    /// The date and time a resource was last backed up, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `LastBackupTime` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    last_backup_time: ?i64 = null,

    /// The ARN (Amazon Resource Name) of the backup vault
    /// that contains the most recent backup recovery point.
    last_backup_vault_arn: ?[]const u8 = null,

    /// The ARN (Amazon Resource Name) of the most
    /// recent recovery point.
    last_recovery_point_arn: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    resource_arn: ?[]const u8 = null,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource; for example, an Amazon Elastic
    /// Block Store (Amazon EBS) volume or an Amazon Relational Database Service
    /// (Amazon RDS) database. For
    /// Windows Volume Shadow Copy Service (VSS) backups, the only supported
    /// resource type is
    /// Amazon EC2.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_backup_time = "LastBackupTime",
        .last_backup_vault_arn = "LastBackupVaultArn",
        .last_recovery_point_arn = "LastRecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
    };
};
