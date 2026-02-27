const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const Endpoint = @import("endpoint.zig").Endpoint;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Detailed information about an instance.
pub const DBInstance = struct {
    /// Does not apply. This parameter does not apply to Amazon DocumentDB. Amazon
    /// DocumentDB does not perform minor version upgrades regardless of the value
    /// set.
    auto_minor_version_upgrade: ?bool,

    /// Specifies the name of the Availability Zone that the instance is located in.
    availability_zone: ?[]const u8,

    /// Specifies the number of days for which automatic snapshots are retained.
    backup_retention_period: ?i32,

    /// The identifier of the CA certificate for this DB instance.
    ca_certificate_identifier: ?[]const u8,

    /// The details of the DB instance's server certificate.
    certificate_details: ?CertificateDetails,

    /// A value that indicates whether to copy tags from the DB instance to
    /// snapshots of the DB instance. By default, tags are not copied.
    copy_tags_to_snapshot: ?bool,

    /// Contains the name of the cluster that the instance is a member of if the
    /// instance is a member of a cluster.
    db_cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the instance.
    db_instance_arn: ?[]const u8,

    /// Contains the name of the compute and memory capacity class of the instance.
    db_instance_class: ?[]const u8,

    /// Contains a user-provided database identifier. This identifier is the unique
    /// key that
    /// identifies an instance.
    db_instance_identifier: ?[]const u8,

    /// Specifies the current state of this database.
    db_instance_status: ?[]const u8,

    /// The Amazon Web Services Region-unique, immutable identifier for the
    /// instance. This identifier is found in CloudTrail log entries whenever the
    /// KMS key for the instance is
    /// accessed.
    dbi_resource_id: ?[]const u8,

    /// Specifies information on the subnet group that is associated with the
    /// instance, including the name, description, and subnets in the subnet group.
    db_subnet_group: ?DBSubnetGroup,

    /// A list of log types that this instance is configured to export to CloudWatch
    /// Logs.
    enabled_cloudwatch_logs_exports: ?[]const []const u8,

    /// Specifies the connection endpoint.
    endpoint: ?Endpoint,

    /// Provides the name of the database engine to be used for this instance.
    engine: ?[]const u8,

    /// Indicates the database engine version.
    engine_version: ?[]const u8,

    /// Provides the date and time that the instance was created.
    instance_create_time: ?i64,

    /// If `StorageEncrypted` is `true`, the KMS key identifier for
    /// the encrypted instance.
    kms_key_id: ?[]const u8,

    /// Specifies the latest time to which a database can be restored with
    /// point-in-time
    /// restore.
    latest_restorable_time: ?i64,

    /// Specifies that changes to the instance are pending. This element is included
    /// only when changes are pending. Specific changes are identified by
    /// subelements.
    pending_modified_values: ?PendingModifiedValues,

    /// Set to `true` if Amazon RDS Performance Insights is enabled for the DB
    /// instance, and otherwise `false`.
    performance_insights_enabled: ?bool,

    /// The KMS key identifier for encryption of Performance Insights data. The KMS
    /// key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key
    /// alias for the KMS encryption key.
    performance_insights_kms_key_id: ?[]const u8,

    /// Specifies the daily time range during which automated backups are created if
    /// automated backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8,

    /// Specifies the weekly time range during which system maintenance can occur,
    /// in
    /// Universal Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8,

    /// A value that specifies the order in which an Amazon DocumentDB replica is
    /// promoted to the
    /// primary instance after a failure of the existing primary instance.
    promotion_tier: ?i32,

    /// Not supported. Amazon DocumentDB does not currently support public
    /// endpoints. The value
    /// of `PubliclyAccessible` is always `false`.
    publicly_accessible: ?bool,

    /// The status of a read replica. If the instance is not a read replica, this is
    /// blank.
    status_infos: ?[]const DBInstanceStatusInfo,

    /// Specifies whether or not the instance is encrypted.
    storage_encrypted: ?bool,

    /// Provides a list of VPC security group elements that the instance belongs to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership,
};
