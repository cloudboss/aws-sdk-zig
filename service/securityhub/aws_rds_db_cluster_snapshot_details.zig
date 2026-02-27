const AwsRdsDbClusterSnapshotDbClusterSnapshotAttribute = @import("aws_rds_db_cluster_snapshot_db_cluster_snapshot_attribute.zig").AwsRdsDbClusterSnapshotDbClusterSnapshotAttribute;

/// Information about an Amazon RDS DB cluster snapshot.
pub const AwsRdsDbClusterSnapshotDetails = struct {
    /// Specifies the allocated storage size in gibibytes (GiB).
    allocated_storage: ?i32,

    /// A list of Availability Zones where instances in the DB cluster can be
    /// created.
    availability_zones: ?[]const []const u8,

    /// Indicates when the DB cluster was created, in Universal Coordinated Time
    /// (UTC).
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    cluster_create_time: ?[]const u8,

    /// The DB cluster identifier.
    db_cluster_identifier: ?[]const u8,

    /// Contains the name and values of a manual DB cluster snapshot attribute.
    db_cluster_snapshot_attributes: ?[]const AwsRdsDbClusterSnapshotDbClusterSnapshotAttribute,

    /// The identifier of the DB cluster snapshot.
    db_cluster_snapshot_identifier: ?[]const u8,

    /// The name of the database engine that you want to use for this DB instance.
    engine: ?[]const u8,

    /// The version of the database engine to use.
    engine_version: ?[]const u8,

    /// Whether mapping of IAM accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool,

    /// The ARN of the KMS master key that is used to encrypt the database instances
    /// in the
    /// DB cluster.
    kms_key_id: ?[]const u8,

    /// The license model information for this DB cluster snapshot.
    license_model: ?[]const u8,

    /// The name of the master user for the DB cluster.
    master_username: ?[]const u8,

    /// Specifies the percentage of the estimated data that has been transferred.
    percent_progress: ?i32,

    /// The port number on which the DB instances in the DB cluster accept
    /// connections.
    port: ?i32,

    /// Indicates when the snapshot was taken.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    snapshot_create_time: ?[]const u8,

    /// The type of DB cluster snapshot.
    snapshot_type: ?[]const u8,

    /// The status of this DB cluster snapshot.
    status: ?[]const u8,

    /// Whether the DB cluster is encrypted.
    storage_encrypted: ?bool,

    /// The VPC ID that is associated with the DB cluster snapshot.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .availability_zones = "AvailabilityZones",
        .cluster_create_time = "ClusterCreateTime",
        .db_cluster_identifier = "DbClusterIdentifier",
        .db_cluster_snapshot_attributes = "DbClusterSnapshotAttributes",
        .db_cluster_snapshot_identifier = "DbClusterSnapshotIdentifier",
        .engine = "Engine",
        .engine_version = "EngineVersion",
        .iam_database_authentication_enabled = "IamDatabaseAuthenticationEnabled",
        .kms_key_id = "KmsKeyId",
        .license_model = "LicenseModel",
        .master_username = "MasterUsername",
        .percent_progress = "PercentProgress",
        .port = "Port",
        .snapshot_create_time = "SnapshotCreateTime",
        .snapshot_type = "SnapshotType",
        .status = "Status",
        .storage_encrypted = "StorageEncrypted",
        .vpc_id = "VpcId",
    };
};
