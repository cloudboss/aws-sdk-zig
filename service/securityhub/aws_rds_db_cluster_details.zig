const AwsRdsDbClusterAssociatedRole = @import("aws_rds_db_cluster_associated_role.zig").AwsRdsDbClusterAssociatedRole;
const AwsRdsDbClusterMember = @import("aws_rds_db_cluster_member.zig").AwsRdsDbClusterMember;
const AwsRdsDbClusterOptionGroupMembership = @import("aws_rds_db_cluster_option_group_membership.zig").AwsRdsDbClusterOptionGroupMembership;
const AwsRdsDbDomainMembership = @import("aws_rds_db_domain_membership.zig").AwsRdsDbDomainMembership;
const AwsRdsDbInstanceVpcSecurityGroup = @import("aws_rds_db_instance_vpc_security_group.zig").AwsRdsDbInstanceVpcSecurityGroup;

/// Information about an Amazon RDS DB cluster.
pub const AwsRdsDbClusterDetails = struct {
    /// The status of the database activity stream. Valid values are as follows:
    ///
    /// * `started`
    ///
    /// * `starting`
    ///
    /// * `stopped`
    ///
    /// * `stopping`
    activity_stream_status: ?[]const u8,

    /// For all database engines except Aurora, specifies the allocated storage size
    /// in
    /// gibibytes (GiB).
    allocated_storage: ?i32,

    /// A list of the IAM roles that are associated with the DB cluster.
    associated_roles: ?[]const AwsRdsDbClusterAssociatedRole,

    /// Indicates if minor version upgrades are automatically applied to the
    /// cluster.
    auto_minor_version_upgrade: ?bool,

    /// A list of Availability Zones (AZs) where instances in the DB cluster can be
    /// created.
    availability_zones: ?[]const []const u8,

    /// The number of days for which automated backups are retained.
    backup_retention_period: ?i32,

    /// Indicates when the DB cluster was created, in Universal Coordinated Time
    /// (UTC).
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    cluster_create_time: ?[]const u8,

    /// Whether tags are copied from the DB cluster to snapshots of the DB cluster.
    copy_tags_to_snapshot: ?bool,

    /// Whether the DB cluster is a clone of a DB cluster owned by a different
    /// Amazon Web Services
    /// account.
    cross_account_clone: ?bool,

    /// A list of custom endpoints for the DB cluster.
    custom_endpoints: ?[]const []const u8,

    /// The name of the database.
    database_name: ?[]const u8,

    /// The DB cluster identifier that the user assigned to the cluster. This
    /// identifier is the
    /// unique key that identifies a DB cluster.
    db_cluster_identifier: ?[]const u8,

    /// The list of instances that make up the DB cluster.
    db_cluster_members: ?[]const AwsRdsDbClusterMember,

    /// The list of option group memberships for this DB cluster.
    db_cluster_option_group_memberships: ?[]const AwsRdsDbClusterOptionGroupMembership,

    /// The name of the DB cluster parameter group for the DB cluster.
    db_cluster_parameter_group: ?[]const u8,

    /// The identifier of the DB cluster. The identifier must be unique within each
    /// Amazon Web Services Region
    /// and is immutable.
    db_cluster_resource_id: ?[]const u8,

    /// The subnet group that is associated with the DB cluster, including the name,
    /// description, and subnets in the subnet group.
    db_subnet_group: ?[]const u8,

    /// Whether the DB cluster has deletion protection enabled.
    deletion_protection: ?bool,

    /// The Active Directory domain membership records that are associated with the
    /// DB
    /// cluster.
    domain_memberships: ?[]const AwsRdsDbDomainMembership,

    /// A list of log types that this DB cluster is configured to export to
    /// CloudWatch
    /// Logs.
    enabled_cloud_watch_logs_exports: ?[]const []const u8,

    /// The connection endpoint for the primary instance of the DB cluster.
    endpoint: ?[]const u8,

    /// The name of the database engine to use for this DB cluster. Valid values are
    /// as follows:
    ///
    /// * `aurora`
    ///
    /// * `aurora-mysql`
    ///
    /// * `aurora-postgresql`
    engine: ?[]const u8,

    /// The database engine mode of the DB cluster.Valid values are as follows:
    ///
    /// * `global`
    ///
    /// * `multimaster`
    ///
    /// * `parallelquery`
    ///
    /// * `provisioned`
    ///
    /// * `serverless`
    engine_mode: ?[]const u8,

    /// The version number of the database engine to use.
    engine_version: ?[]const u8,

    /// Specifies the identifier that Amazon Route 53 assigns when you create a
    /// hosted
    /// zone.
    hosted_zone_id: ?[]const u8,

    /// Whether the HTTP endpoint for an Aurora Serverless DB cluster is enabled.
    http_endpoint_enabled: ?bool,

    /// Whether the mapping of IAM accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool,

    /// The ARN of the KMS master key that is used to encrypt the database instances
    /// in the
    /// DB cluster.
    kms_key_id: ?[]const u8,

    /// The name of the master user for the DB cluster.
    master_username: ?[]const u8,

    /// Whether the DB cluster has instances in multiple Availability Zones.
    multi_az: ?bool,

    /// The port number on which the DB instances in the DB cluster accept
    /// connections.
    port: ?i32,

    /// The range of time each day when automated backups are created, if automated
    /// backups are
    /// enabled.
    ///
    /// Uses the format `HH:MM-HH:MM`. For example, `04:52-05:22`.
    preferred_backup_window: ?[]const u8,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal
    /// Coordinated Time (UTC).
    ///
    /// Uses the format `:HH:MM-:HH:MM`.
    ///
    /// For the day values, use
    /// `mon`|`tue`|`wed`|`thu`|`fri`|`sat`|`sun`.
    ///
    /// For example, `sun:09:32-sun:10:02`.
    preferred_maintenance_window: ?[]const u8,

    /// The reader endpoint for the DB cluster.
    reader_endpoint: ?[]const u8,

    /// The identifiers of the read replicas that are associated with this DB
    /// cluster.
    read_replica_identifiers: ?[]const []const u8,

    /// The current status of this DB cluster.
    status: ?[]const u8,

    /// Whether the DB cluster is encrypted.
    storage_encrypted: ?bool,

    /// A list of VPC security groups that the DB cluster belongs to.
    vpc_security_groups: ?[]const AwsRdsDbInstanceVpcSecurityGroup,

    pub const json_field_names = .{
        .activity_stream_status = "ActivityStreamStatus",
        .allocated_storage = "AllocatedStorage",
        .associated_roles = "AssociatedRoles",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zones = "AvailabilityZones",
        .backup_retention_period = "BackupRetentionPeriod",
        .cluster_create_time = "ClusterCreateTime",
        .copy_tags_to_snapshot = "CopyTagsToSnapshot",
        .cross_account_clone = "CrossAccountClone",
        .custom_endpoints = "CustomEndpoints",
        .database_name = "DatabaseName",
        .db_cluster_identifier = "DbClusterIdentifier",
        .db_cluster_members = "DbClusterMembers",
        .db_cluster_option_group_memberships = "DbClusterOptionGroupMemberships",
        .db_cluster_parameter_group = "DbClusterParameterGroup",
        .db_cluster_resource_id = "DbClusterResourceId",
        .db_subnet_group = "DbSubnetGroup",
        .deletion_protection = "DeletionProtection",
        .domain_memberships = "DomainMemberships",
        .enabled_cloud_watch_logs_exports = "EnabledCloudWatchLogsExports",
        .endpoint = "Endpoint",
        .engine = "Engine",
        .engine_mode = "EngineMode",
        .engine_version = "EngineVersion",
        .hosted_zone_id = "HostedZoneId",
        .http_endpoint_enabled = "HttpEndpointEnabled",
        .iam_database_authentication_enabled = "IamDatabaseAuthenticationEnabled",
        .kms_key_id = "KmsKeyId",
        .master_username = "MasterUsername",
        .multi_az = "MultiAz",
        .port = "Port",
        .preferred_backup_window = "PreferredBackupWindow",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .reader_endpoint = "ReaderEndpoint",
        .read_replica_identifiers = "ReadReplicaIdentifiers",
        .status = "Status",
        .storage_encrypted = "StorageEncrypted",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
