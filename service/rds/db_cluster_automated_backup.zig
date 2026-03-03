const RestoreWindow = @import("restore_window.zig").RestoreWindow;
const Tag = @import("tag.zig").Tag;

/// An automated backup of a DB cluster. It consists of system backups,
/// transaction logs, and the database cluster properties that existed at the
/// time you deleted the source cluster.
pub const DBClusterAutomatedBackup = struct {
    /// For all database engines except Amazon Aurora, `AllocatedStorage` specifies
    /// the allocated storage size in gibibytes (GiB). For Aurora,
    /// `AllocatedStorage` always returns 1, because Aurora DB cluster storage size
    /// isn't fixed, but instead automatically adjusts as needed.
    allocated_storage: ?i32 = null,

    /// The Availability Zones where instances in the DB cluster can be created. For
    /// information on Amazon Web Services Regions and Availability Zones, see
    /// [Regions and Availability
    /// Zones](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.RegionsAndAvailabilityZones.html).
    availability_zones: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the recovery point in Amazon Web Services
    /// Backup.
    aws_backup_recovery_point_arn: ?[]const u8 = null,

    /// The retention period for the automated backups.
    backup_retention_period: ?i32 = null,

    /// The time when the DB cluster was created, in Universal Coordinated Time
    /// (UTC).
    cluster_create_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the source DB cluster.
    db_cluster_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the automated backups.
    db_cluster_automated_backups_arn: ?[]const u8 = null,

    /// The identifier for the source DB cluster, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    db_cluster_identifier: ?[]const u8 = null,

    /// The resource ID for the source DB cluster, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    db_cluster_resource_id: ?[]const u8 = null,

    /// The name of the database engine for this automated backup.
    engine: ?[]const u8 = null,

    /// The engine mode of the database engine for the automated backup.
    engine_mode: ?[]const u8 = null,

    /// The version of the database engine for the automated backup.
    engine_version: ?[]const u8 = null,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool = null,

    /// The IOPS (I/O operations per second) value for the automated backup.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    iops: ?i32 = null,

    /// The Amazon Web Services KMS key ID for an automated backup.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The license model information for this DB cluster automated backup.
    license_model: ?[]const u8 = null,

    /// The master user name of the automated backup.
    master_username: ?[]const u8 = null,

    /// The port number that the automated backup used for connections.
    ///
    /// Default: Inherits from the source DB cluster
    ///
    /// Valid Values: `1150-65535`
    port: ?i32 = null,

    /// The Amazon Web Services Region associated with the automated backup.
    region: ?[]const u8 = null,

    restore_window: ?RestoreWindow = null,

    /// A list of status information for an automated backup:
    ///
    /// * `retained` - Automated backups for deleted clusters.
    status: ?[]const u8 = null,

    /// Indicates whether the source DB cluster is encrypted.
    storage_encrypted: ?bool = null,

    /// The storage throughput for the automated backup. The throughput is
    /// automatically set based on the IOPS that you provision, and is not
    /// configurable.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    storage_throughput: ?i32 = null,

    /// The storage type associated with the DB cluster.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    storage_type: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    /// The VPC ID associated with the DB cluster.
    vpc_id: ?[]const u8 = null,
};
