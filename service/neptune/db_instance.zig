const DBParameterGroupStatus = @import("db_parameter_group_status.zig").DBParameterGroupStatus;
const DBSecurityGroupMembership = @import("db_security_group_membership.zig").DBSecurityGroupMembership;
const DBSubnetGroup = @import("db_subnet_group.zig").DBSubnetGroup;
const DomainMembership = @import("domain_membership.zig").DomainMembership;
const Endpoint = @import("endpoint.zig").Endpoint;
const OptionGroupMembership = @import("option_group_membership.zig").OptionGroupMembership;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const DBInstanceStatusInfo = @import("db_instance_status_info.zig").DBInstanceStatusInfo;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Contains the details of an Amazon Neptune DB instance.
///
/// This data type is used as a response element in the DescribeDBInstances
/// action.
pub const DBInstance = struct {
    /// Not supported by Neptune.
    allocated_storage: ?i32 = null,

    /// Indicates that minor version patches are applied automatically.
    auto_minor_version_upgrade: ?bool = null,

    /// Specifies the name of the Availability Zone the DB instance is located in.
    availability_zone: ?[]const u8 = null,

    /// Specifies the number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32 = null,

    /// The identifier of the CA certificate for this DB instance.
    ca_certificate_identifier: ?[]const u8 = null,

    /// *(Not supported by Neptune)*
    character_set_name: ?[]const u8 = null,

    /// Specifies whether tags are copied from the DB instance to snapshots of the
    /// DB
    /// instance.
    copy_tags_to_snapshot: ?bool = null,

    /// If the DB instance is a member of a DB cluster, contains the name of the DB
    /// cluster that
    /// the DB instance is a member of.
    db_cluster_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the DB instance.
    db_instance_arn: ?[]const u8 = null,

    /// Contains the name of the compute and memory capacity class of the DB
    /// instance.
    db_instance_class: ?[]const u8 = null,

    /// Contains a user-supplied database identifier. This identifier is the unique
    /// key that
    /// identifies a DB instance.
    db_instance_identifier: ?[]const u8 = null,

    /// Specifies the port that the DB instance listens on. If the DB instance is
    /// part of a DB
    /// cluster, this can be a different port than the DB cluster port.
    db_instance_port: ?i32 = null,

    /// Specifies the current state of this database.
    db_instance_status: ?[]const u8 = null,

    /// The Amazon Region-unique, immutable identifier for the DB instance. This
    /// identifier is found
    /// in Amazon CloudTrail log entries whenever the Amazon KMS key for the DB
    /// instance is accessed.
    dbi_resource_id: ?[]const u8 = null,

    /// The database name.
    db_name: ?[]const u8 = null,

    /// Provides the list of DB parameter groups applied to this DB instance.
    db_parameter_groups: ?[]const DBParameterGroupStatus = null,

    /// Provides List of DB security group elements containing only
    /// `DBSecurityGroup.Name` and `DBSecurityGroup.Status` subelements.
    db_security_groups: ?[]const DBSecurityGroupMembership = null,

    /// Specifies information on the subnet group associated with the DB instance,
    /// including the
    /// name, description, and subnets in the subnet group.
    db_subnet_group: ?DBSubnetGroup = null,

    /// Indicates whether or not the DB instance has deletion protection enabled.
    /// The instance can't be deleted when deletion protection is enabled. See
    /// [Deleting
    /// a DB
    /// Instance](https://docs.aws.amazon.com/neptune/latest/userguide/manage-console-instances-delete.html).
    deletion_protection: ?bool = null,

    /// Not supported
    domain_memberships: ?[]const DomainMembership = null,

    /// A list of log types that this DB instance is configured to export to
    /// CloudWatch
    /// Logs.
    enabled_cloudwatch_logs_exports: ?[]const []const u8 = null,

    /// Specifies the connection endpoint.
    endpoint: ?Endpoint = null,

    /// Provides the name of the database engine to be used for this DB instance.
    engine: ?[]const u8 = null,

    /// Indicates the database engine version.
    engine_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log stream that
    /// receives the
    /// Enhanced Monitoring metrics data for the DB instance.
    enhanced_monitoring_resource_arn: ?[]const u8 = null,

    /// True if Amazon Identity and Access Management (IAM) authentication is
    /// enabled, and otherwise
    /// false.
    iam_database_authentication_enabled: ?bool = null,

    /// Provides the date and time the DB instance was created.
    instance_create_time: ?i64 = null,

    /// Specifies the Provisioned IOPS (I/O operations per second) value.
    iops: ?i32 = null,

    /// Not supported: The encryption for DB instances is managed by the DB cluster.
    kms_key_id: ?[]const u8 = null,

    /// Specifies the latest time to which a database can be restored with
    /// point-in-time
    /// restore.
    latest_restorable_time: ?i64 = null,

    /// License model information for this DB instance.
    license_model: ?[]const u8 = null,

    /// Not supported by Neptune.
    master_username: ?[]const u8 = null,

    /// The interval, in seconds, between points when Enhanced Monitoring metrics
    /// are collected
    /// for the DB instance.
    monitoring_interval: ?i32 = null,

    /// The ARN for the IAM role that permits Neptune to send Enhanced Monitoring
    /// metrics to
    /// Amazon CloudWatch Logs.
    monitoring_role_arn: ?[]const u8 = null,

    /// Specifies if the DB instance is a Multi-AZ deployment.
    multi_az: ?bool = null,

    /// *(Not supported by Neptune)*
    option_group_memberships: ?[]const OptionGroupMembership = null,

    /// Specifies that changes to the DB instance are pending. This element is only
    /// included when
    /// changes are pending. Specific changes are identified by subelements.
    pending_modified_values: ?PendingModifiedValues = null,

    /// *(Not supported by Neptune)*
    performance_insights_enabled: ?bool = null,

    /// *(Not supported by Neptune)*
    performance_insights_kms_key_id: ?[]const u8 = null,

    /// Specifies the daily time range during which automated backups are created if
    /// automated
    /// backups are enabled, as determined by the `BackupRetentionPeriod`.
    preferred_backup_window: ?[]const u8 = null,

    /// Specifies the weekly time range during which system maintenance can occur,
    /// in Universal
    /// Coordinated Time (UTC).
    preferred_maintenance_window: ?[]const u8 = null,

    /// A value that specifies the order in which a Read Replica is promoted to the
    /// primary
    /// instance after a failure of the existing primary instance.
    promotion_tier: ?i32 = null,

    /// Indicates whether the DB instance is publicly accessible.
    ///
    /// When the DB instance is publicly accessible and you connect from outside of
    /// the DB instance's virtual private
    /// cloud (VPC), its Domain Name System (DNS) endpoint resolves to the public IP
    /// address. When you connect from within
    /// the same VPC as the DB instance, the endpoint resolves to the private IP
    /// address. Access to the DB instance is
    /// ultimately controlled by the security group it uses. That public access
    /// isn't permitted if the security group assigned
    /// to the DB cluster doesn't permit it.
    ///
    /// When the DB instance isn't publicly accessible, it is an internal DB
    /// instance with a DNS name that resolves to a
    /// private IP address.
    publicly_accessible: ?bool = null,

    /// Contains one or more identifiers of DB clusters that are Read Replicas of
    /// this DB
    /// instance.
    read_replica_db_cluster_identifiers: ?[]const []const u8 = null,

    /// Contains one or more identifiers of the Read Replicas associated with this
    /// DB
    /// instance.
    read_replica_db_instance_identifiers: ?[]const []const u8 = null,

    /// Contains the identifier of the source DB instance if this DB instance is a
    /// Read
    /// Replica.
    read_replica_source_db_instance_identifier: ?[]const u8 = null,

    /// If present, specifies the name of the secondary Availability Zone for a DB
    /// instance with
    /// multi-AZ support.
    secondary_availability_zone: ?[]const u8 = null,

    /// The status of a Read Replica. If the instance is not a Read Replica, this is
    /// blank.
    status_infos: ?[]const DBInstanceStatusInfo = null,

    /// Not supported: The encryption for DB instances is managed by the DB cluster.
    storage_encrypted: ?bool = null,

    /// Specifies the storage type associated with the DB instance.
    storage_type: ?[]const u8 = null,

    /// The ARN from the key store with which the instance is associated for TDE
    /// encryption.
    tde_credential_arn: ?[]const u8 = null,

    /// Not supported.
    timezone: ?[]const u8 = null,

    /// Provides a list of VPC security group elements that the DB instance belongs
    /// to.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership = null,
};
