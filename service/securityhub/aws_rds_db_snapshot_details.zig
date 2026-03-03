const AwsRdsDbProcessorFeature = @import("aws_rds_db_processor_feature.zig").AwsRdsDbProcessorFeature;

/// Provides details about an Amazon RDS DB cluster snapshot.
pub const AwsRdsDbSnapshotDetails = struct {
    /// The amount of storage (in gigabytes) to be initially allocated for the
    /// database instance.
    allocated_storage: ?i32 = null,

    /// Specifies the name of the Availability Zone in which the DB instance was
    /// located at the time of the DB snapshot.
    availability_zone: ?[]const u8 = null,

    /// A name for the DB instance.
    db_instance_identifier: ?[]const u8 = null,

    /// The identifier for the source DB instance.
    dbi_resource_id: ?[]const u8 = null,

    /// The name or ARN of the DB snapshot that is used to restore the DB instance.
    db_snapshot_identifier: ?[]const u8 = null,

    /// Whether the DB snapshot is encrypted.
    encrypted: ?bool = null,

    /// The name of the database engine to use for this DB instance. Valid values
    /// are as follows:
    ///
    /// * `aurora`
    ///
    /// * `aurora-mysql`
    ///
    /// * `aurora-postgresql`
    ///
    /// * `c`
    ///
    /// * `mariadb`
    ///
    /// * `mysql`
    ///
    /// * `oracle-ee`
    ///
    /// * `oracle-se`
    ///
    /// * `oracle-se1`
    ///
    /// * `oracle-se2`
    ///
    /// * `sqlserver-ee`
    ///
    /// * `sqlserver-ex`
    ///
    /// * `sqlserver-se`
    ///
    /// * `sqlserver-web`
    engine: ?[]const u8 = null,

    /// The version of the database engine.
    engine_version: ?[]const u8 = null,

    /// Whether mapping of IAM accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool = null,

    /// Specifies the time in Coordinated Universal Time (UTC) when the DB instance,
    /// from which the snapshot was taken, was created.
    instance_create_time: ?[]const u8 = null,

    /// The provisioned IOPS (I/O operations per second) value of the DB instance at
    /// the time of the snapshot.
    iops: ?i32 = null,

    /// If `Encrypted` is `true`, the KMS key identifier for the encrypted DB
    /// snapshot.
    kms_key_id: ?[]const u8 = null,

    /// License model information for the restored DB instance.
    license_model: ?[]const u8 = null,

    /// The master user name for the DB snapshot.
    master_username: ?[]const u8 = null,

    /// The option group name for the DB snapshot.
    option_group_name: ?[]const u8 = null,

    /// The percentage of the estimated data that has been transferred.
    percent_progress: ?i32 = null,

    /// The port that the database engine was listening on at the time of the
    /// snapshot.
    port: ?i32 = null,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance.
    processor_features: ?[]const AwsRdsDbProcessorFeature = null,

    /// When the snapshot was taken in Coordinated Universal Time (UTC).
    snapshot_create_time: ?[]const u8 = null,

    /// The type of the DB snapshot.
    snapshot_type: ?[]const u8 = null,

    /// The DB snapshot ARN that the DB snapshot was copied from.
    source_db_snapshot_identifier: ?[]const u8 = null,

    /// The Amazon Web Services Region that the DB snapshot was created in or copied
    /// from.
    source_region: ?[]const u8 = null,

    /// The status of this DB snapshot.
    status: ?[]const u8 = null,

    /// The storage type associated with the DB snapshot. Valid values are as
    /// follows:
    ///
    /// * `gp2`
    ///
    /// * `io1`
    ///
    /// * `standard`
    storage_type: ?[]const u8 = null,

    /// The ARN from the key store with which to associate the instance for TDE
    /// encryption.
    tde_credential_arn: ?[]const u8 = null,

    /// The time zone of the DB snapshot.
    timezone: ?[]const u8 = null,

    /// The VPC ID associated with the DB snapshot.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .availability_zone = "AvailabilityZone",
        .db_instance_identifier = "DbInstanceIdentifier",
        .dbi_resource_id = "DbiResourceId",
        .db_snapshot_identifier = "DbSnapshotIdentifier",
        .encrypted = "Encrypted",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .iam_database_authentication_enabled = "IamDatabaseAuthenticationEnabled",
        .instance_create_time = "InstanceCreateTime",
        .iops = "Iops",
        .kms_key_id = "KmsKeyId",
        .license_model = "LicenseModel",
        .master_username = "MasterUsername",
        .option_group_name = "OptionGroupName",
        .percent_progress = "PercentProgress",
        .port = "Port",
        .processor_features = "ProcessorFeatures",
        .snapshot_create_time = "SnapshotCreateTime",
        .snapshot_type = "SnapshotType",
        .source_db_snapshot_identifier = "SourceDbSnapshotIdentifier",
        .source_region = "SourceRegion",
        .status = "Status",
        .storage_type = "StorageType",
        .tde_credential_arn = "TdeCredentialArn",
        .timezone = "Timezone",
        .vpc_id = "VpcId",
    };
};
