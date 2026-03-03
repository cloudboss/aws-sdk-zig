const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const DBInstanceAutomatedBackupsReplication = @import("db_instance_automated_backups_replication.zig").DBInstanceAutomatedBackupsReplication;
const RestoreWindow = @import("restore_window.zig").RestoreWindow;
const Tag = @import("tag.zig").Tag;

/// An automated backup of a DB instance. It consists of system backups,
/// transaction logs, and the database instance properties that existed at the
/// time you deleted the source instance.
pub const DBInstanceAutomatedBackup = struct {
    /// The additional storage volumes associated with the automated backup.
    ///
    /// Valid Values: `GP3 | IO2`
    additional_storage_volumes: ?[]const AdditionalStorageVolume = null,

    /// The allocated storage size for the automated backup in gibibytes (GiB).
    allocated_storage: ?i32 = null,

    /// The Availability Zone that the automated backup was created in. For
    /// information on Amazon Web Services Regions and Availability Zones, see
    /// [Regions and Availability
    /// Zones](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html).
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    aws_backup_recovery_point_arn: ?[]const u8 = null,

    /// The retention period for the automated backups.
    backup_retention_period: ?i32 = null,

    /// The location where automated backups are stored: Dedicated Local Zones,
    /// Amazon Web Services Outposts or the Amazon Web Services Region.
    backup_target: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the automated backups.
    db_instance_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the replicated automated backups.
    db_instance_automated_backups_arn: ?[]const u8 = null,

    /// The list of replications to different Amazon Web Services Regions associated
    /// with the automated backup.
    db_instance_automated_backups_replications: ?[]const DBInstanceAutomatedBackupsReplication = null,

    /// The identifier for the source DB instance, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    db_instance_identifier: ?[]const u8 = null,

    /// The resource ID for the source DB instance, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    dbi_resource_id: ?[]const u8 = null,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool = null,

    /// Indicates whether the automated backup is encrypted.
    encrypted: ?bool = null,

    /// The name of the database engine for this automated backup.
    engine: ?[]const u8 = null,

    /// The version of the database engine for the automated backup.
    engine_version: ?[]const u8 = null,

    /// True if mapping of Amazon Web Services Identity and Access Management (IAM)
    /// accounts to database accounts is enabled, and otherwise false.
    iam_database_authentication_enabled: ?bool = null,

    /// The date and time when the DB instance was created.
    instance_create_time: ?i64 = null,

    /// The IOPS (I/O operations per second) value for the automated backup.
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key ID for an automated backup.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The license model information for the automated backup.
    license_model: ?[]const u8 = null,

    /// The master user name of an automated backup.
    master_username: ?[]const u8 = null,

    /// Specifies whether the automatic backup is for a DB instance in the
    /// multi-tenant configuration (TRUE) or the single-tenant configuration
    /// (FALSE).
    multi_tenant: ?bool = null,

    /// The option group the automated backup is associated with. If omitted, the
    /// default option group for the engine specified is used.
    option_group_name: ?[]const u8 = null,

    /// The port number that the automated backup used for connections.
    ///
    /// Default: Inherits from the source DB instance
    ///
    /// Valid Values: `1150-65535`
    port: ?i32 = null,

    /// The Amazon Web Services Region associated with the automated backup.
    region: ?[]const u8 = null,

    /// The earliest and latest time a DB instance can be restored to.
    restore_window: ?RestoreWindow = null,

    /// A list of status information for an automated backup:
    ///
    /// * `active` - Automated backups for current instances.
    /// * `retained` - Automated backups for deleted instances.
    /// * `creating` - Automated backups that are waiting for the first automated
    ///   snapshot to be available.
    status: ?[]const u8 = null,

    /// The storage throughput for the automated backup.
    storage_throughput: ?i32 = null,

    /// The storage type associated with the automated backup.
    storage_type: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    /// The ARN from the key store with which the automated backup is associated for
    /// TDE encryption.
    tde_credential_arn: ?[]const u8 = null,

    /// The time zone of the automated backup. In most cases, the `Timezone` element
    /// is empty. `Timezone` content appears only for Microsoft SQL Server DB
    /// instances that were created with a time zone specified.
    timezone: ?[]const u8 = null,

    /// The VPC ID associated with the DB instance.
    vpc_id: ?[]const u8 = null,
};
