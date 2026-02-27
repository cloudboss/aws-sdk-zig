const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;
const Tag = @import("tag.zig").Tag;

/// Contains the details of an Amazon RDS DB snapshot.
///
/// This data type is used as a response element in the `DescribeDBSnapshots`
/// action.
pub const DBSnapshot = struct {
    /// The additional storage volumes associated with the DB snapshot. RDS supports
    /// additional storage volumes for RDS for Oracle and RDS for SQL Server.
    additional_storage_volumes: ?[]const AdditionalStorageVolume,

    /// Specifies the allocated storage size in gibibytes (GiB).
    allocated_storage: ?i32,

    /// Specifies the name of the Availability Zone the DB instance was located in
    /// at the time of the DB snapshot.
    availability_zone: ?[]const u8,

    /// Specifies the DB instance identifier of the DB instance this DB snapshot was
    /// created from.
    db_instance_identifier: ?[]const u8,

    /// The identifier for the source DB instance, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    dbi_resource_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the DB snapshot.
    db_snapshot_arn: ?[]const u8,

    /// Specifies the identifier for the DB snapshot.
    db_snapshot_identifier: ?[]const u8,

    /// The Oracle system identifier (SID), which is the name of the Oracle database
    /// instance that manages your database files. The Oracle SID is also the name
    /// of your CDB.
    db_system_id: ?[]const u8,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.
    dedicated_log_volume: ?bool,

    /// Indicates whether the DB snapshot is encrypted.
    encrypted: ?bool,

    /// Specifies the name of the database engine.
    engine: ?[]const u8,

    /// Specifies the version of the database engine.
    engine_version: ?[]const u8,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool,

    /// Specifies the time in Coordinated Universal Time (UTC) when the DB instance,
    /// from which the snapshot was taken, was created.
    instance_create_time: ?i64,

    /// Specifies the Provisioned IOPS (I/O operations per second) value of the DB
    /// instance at the time of the snapshot.
    iops: ?i32,

    /// If `Encrypted` is true, the Amazon Web Services KMS key identifier for the
    /// encrypted DB snapshot.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8,

    /// License model information for the restored DB instance.
    license_model: ?[]const u8,

    /// Provides the master username for the DB snapshot.
    master_username: ?[]const u8,

    /// Indicates whether the snapshot is of a DB instance using the multi-tenant
    /// configuration (TRUE) or the single-tenant configuration (FALSE).
    multi_tenant: ?bool,

    /// Provides the option group name for the DB snapshot.
    option_group_name: ?[]const u8,

    /// Specifies the time of the CreateDBSnapshot operation in Coordinated
    /// Universal Time (UTC). Doesn't change when the snapshot is copied.
    original_snapshot_create_time: ?i64,

    /// The percentage of the estimated data that has been transferred.
    percent_progress: ?i32,

    /// Specifies the port that the database engine was listening on at the time of
    /// the snapshot.
    port: ?i32,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance when the DB snapshot was created.
    processor_features: ?[]const ProcessorFeature,

    /// Specifies the name of the Availability Zone where RDS stores the DB
    /// snapshot. This value is valid only for snapshots that RDS stores on a
    /// Dedicated Local Zone.
    snapshot_availability_zone: ?[]const u8,

    /// Specifies when the snapshot was taken in Coordinated Universal Time (UTC).
    /// Changes for the copy when the snapshot is copied.
    snapshot_create_time: ?i64,

    /// The timestamp of the most recent transaction applied to the database that
    /// you're backing up. Thus, if you restore a snapshot, SnapshotDatabaseTime is
    /// the most recent transaction in the restored DB instance. In contrast,
    /// originalSnapshotCreateTime specifies the system time that the snapshot
    /// completed.
    ///
    /// If you back up a read replica, you can determine the replica lag by
    /// comparing SnapshotDatabaseTime with originalSnapshotCreateTime. For example,
    /// if originalSnapshotCreateTime is two hours later than SnapshotDatabaseTime,
    /// then the replica lag is two hours.
    snapshot_database_time: ?i64,

    /// Specifies where manual snapshots are stored: Dedicated Local Zones, Amazon
    /// Web Services Outposts or the Amazon Web Services Region.
    snapshot_target: ?[]const u8,

    /// Provides the type of the DB snapshot.
    snapshot_type: ?[]const u8,

    /// The DB snapshot Amazon Resource Name (ARN) that the DB snapshot was copied
    /// from. It only has a value in the case of a cross-account or cross-Region
    /// copy.
    source_db_snapshot_identifier: ?[]const u8,

    /// The Amazon Web Services Region that the DB snapshot was created in or copied
    /// from.
    source_region: ?[]const u8,

    /// Specifies the status of this DB snapshot.
    status: ?[]const u8,

    /// Specifies the storage throughput for the DB snapshot.
    storage_throughput: ?i32,

    /// Specifies the storage type associated with DB snapshot.
    storage_type: ?[]const u8,

    tag_list: ?[]const Tag,

    /// The ARN from the key store with which to associate the instance for TDE
    /// encryption.
    tde_credential_arn: ?[]const u8,

    /// The time zone of the DB snapshot. In most cases, the `Timezone` element is
    /// empty. `Timezone` content appears only for snapshots taken from Microsoft
    /// SQL Server DB instances that were created with a time zone specified.
    timezone: ?[]const u8,

    /// Provides the VPC ID associated with the DB snapshot.
    vpc_id: ?[]const u8,
};
