const AwsRedshiftClusterClusterNode = @import("aws_redshift_cluster_cluster_node.zig").AwsRedshiftClusterClusterNode;
const AwsRedshiftClusterClusterParameterGroup = @import("aws_redshift_cluster_cluster_parameter_group.zig").AwsRedshiftClusterClusterParameterGroup;
const AwsRedshiftClusterClusterSecurityGroup = @import("aws_redshift_cluster_cluster_security_group.zig").AwsRedshiftClusterClusterSecurityGroup;
const AwsRedshiftClusterClusterSnapshotCopyStatus = @import("aws_redshift_cluster_cluster_snapshot_copy_status.zig").AwsRedshiftClusterClusterSnapshotCopyStatus;
const AwsRedshiftClusterDeferredMaintenanceWindow = @import("aws_redshift_cluster_deferred_maintenance_window.zig").AwsRedshiftClusterDeferredMaintenanceWindow;
const AwsRedshiftClusterElasticIpStatus = @import("aws_redshift_cluster_elastic_ip_status.zig").AwsRedshiftClusterElasticIpStatus;
const AwsRedshiftClusterEndpoint = @import("aws_redshift_cluster_endpoint.zig").AwsRedshiftClusterEndpoint;
const AwsRedshiftClusterHsmStatus = @import("aws_redshift_cluster_hsm_status.zig").AwsRedshiftClusterHsmStatus;
const AwsRedshiftClusterIamRole = @import("aws_redshift_cluster_iam_role.zig").AwsRedshiftClusterIamRole;
const AwsRedshiftClusterLoggingStatus = @import("aws_redshift_cluster_logging_status.zig").AwsRedshiftClusterLoggingStatus;
const AwsRedshiftClusterPendingModifiedValues = @import("aws_redshift_cluster_pending_modified_values.zig").AwsRedshiftClusterPendingModifiedValues;
const AwsRedshiftClusterResizeInfo = @import("aws_redshift_cluster_resize_info.zig").AwsRedshiftClusterResizeInfo;
const AwsRedshiftClusterRestoreStatus = @import("aws_redshift_cluster_restore_status.zig").AwsRedshiftClusterRestoreStatus;
const AwsRedshiftClusterVpcSecurityGroup = @import("aws_redshift_cluster_vpc_security_group.zig").AwsRedshiftClusterVpcSecurityGroup;

/// Details about an Amazon Redshift cluster.
pub const AwsRedshiftClusterDetails = struct {
    /// Indicates whether major version upgrades are applied automatically to the
    /// cluster during
    /// the maintenance window.
    allow_version_upgrade: ?bool = null,

    /// The number of days that automatic cluster snapshots are retained.
    automated_snapshot_retention_period: ?i32 = null,

    /// The name of the Availability Zone in which the cluster is located.
    availability_zone: ?[]const u8 = null,

    /// The availability status of the cluster for queries. Possible values are the
    /// following:
    ///
    /// * `Available` - The cluster is available for queries.
    ///
    /// * `Unavailable` - The cluster is not available for queries.
    ///
    /// * `Maintenance` - The cluster is intermittently available for queries due
    /// to maintenance activities.
    ///
    /// * `Modifying` -The cluster is intermittently available for queries due to
    /// changes that modify the cluster.
    ///
    /// * `Failed` - The cluster failed and is not available for queries.
    cluster_availability_status: ?[]const u8 = null,

    /// Indicates when the cluster was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    cluster_create_time: ?[]const u8 = null,

    /// The unique identifier of the cluster.
    cluster_identifier: ?[]const u8 = null,

    /// The nodes in the cluster.
    cluster_nodes: ?[]const AwsRedshiftClusterClusterNode = null,

    /// The list of cluster parameter groups that are associated with this cluster.
    cluster_parameter_groups: ?[]const AwsRedshiftClusterClusterParameterGroup = null,

    /// The public key for the cluster.
    cluster_public_key: ?[]const u8 = null,

    /// The specific revision number of the database in the cluster.
    cluster_revision_number: ?[]const u8 = null,

    /// A list of cluster security groups that are associated with the cluster.
    cluster_security_groups: ?[]const AwsRedshiftClusterClusterSecurityGroup = null,

    /// Information about the destination Region and retention period for the
    /// cross-Region
    /// snapshot copy.
    cluster_snapshot_copy_status: ?AwsRedshiftClusterClusterSnapshotCopyStatus = null,

    /// The current status of the cluster.
    ///
    /// Valid values: `available` | `available, prep-for-resize` |
    /// `available, resize-cleanup` |` cancelling-resize` |
    /// `creating` | `deleting` | `final-snapshot` |
    /// `hardware-failure` | `incompatible-hsm` |`
    /// incompatible-network` | `incompatible-parameters` |
    /// `incompatible-restore` | `modifying` | `paused` |
    /// `rebooting` | `renaming` | `resizing` |
    /// `rotating-keys` | `storage-full` |
    /// `updating-hsm`
    cluster_status: ?[]const u8 = null,

    /// The name of the subnet group that is associated with the cluster. This
    /// parameter is
    /// valid only when the cluster is in a VPC.
    cluster_subnet_group_name: ?[]const u8 = null,

    /// The version ID of the Amazon Redshift engine that runs on the cluster.
    cluster_version: ?[]const u8 = null,

    /// The name of the initial database that was created when the cluster was
    /// created.
    ///
    /// The same name is returned for the life of the cluster.
    ///
    /// If an initial database is not specified, a database named `devdev` is
    /// created
    /// by default.
    db_name: ?[]const u8 = null,

    /// List of time windows during which maintenance was deferred.
    deferred_maintenance_windows: ?[]const AwsRedshiftClusterDeferredMaintenanceWindow = null,

    /// Information about the status of the Elastic IP (EIP) address.
    elastic_ip_status: ?AwsRedshiftClusterElasticIpStatus = null,

    /// The number of nodes that you can use the elastic resize method to resize the
    /// cluster
    /// to.
    elastic_resize_number_of_node_options: ?[]const u8 = null,

    /// Indicates whether the data in the cluster is encrypted at rest.
    encrypted: ?bool = null,

    /// The connection endpoint.
    endpoint: ?AwsRedshiftClusterEndpoint = null,

    /// Indicates whether to create the cluster with enhanced VPC routing enabled.
    enhanced_vpc_routing: ?bool = null,

    /// Indicates when the next snapshot is expected to be taken. The cluster must
    /// have a valid
    /// snapshot schedule and have backups enabled.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    expected_next_snapshot_schedule_time: ?[]const u8 = null,

    /// The status of the next expected snapshot.
    ///
    /// Valid values: `OnTrack` | `Pending`
    expected_next_snapshot_schedule_time_status: ?[]const u8 = null,

    /// Information about whether the Amazon Redshift cluster finished applying any
    /// changes to
    /// hardware security module (HSM) settings that were specified in a modify
    /// cluster
    /// command.
    hsm_status: ?AwsRedshiftClusterHsmStatus = null,

    /// A list of IAM roles that the cluster can use to access other Amazon Web
    /// Services services.
    iam_roles: ?[]const AwsRedshiftClusterIamRole = null,

    /// The identifier of the KMS encryption key that is used to encrypt data in the
    /// cluster.
    kms_key_id: ?[]const u8 = null,

    /// Information about the logging status of the cluster.
    logging_status: ?AwsRedshiftClusterLoggingStatus = null,

    /// The name of the maintenance track for the cluster.
    maintenance_track_name: ?[]const u8 = null,

    /// The default number of days to retain a manual snapshot.
    ///
    /// If the value is `-1`, the snapshot is retained indefinitely.
    ///
    /// This setting doesn't change the retention period of existing snapshots.
    ///
    /// Valid values: Either `-1` or an integer between 1 and 3,653
    manual_snapshot_retention_period: ?i32 = null,

    /// The master user name for the cluster. This name is used to connect to the
    /// database that
    /// is specified in as the value of `DBName`.
    master_username: ?[]const u8 = null,

    /// Indicates the start of the next maintenance window.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    next_maintenance_window_start_time: ?[]const u8 = null,

    /// The node type for the nodes in the cluster.
    node_type: ?[]const u8 = null,

    /// The number of compute nodes in the cluster.
    number_of_nodes: ?i32 = null,

    /// A list of cluster operations that are waiting to start.
    pending_actions: ?[]const []const u8 = null,

    /// A list of changes to the cluster that are currently pending.
    pending_modified_values: ?AwsRedshiftClusterPendingModifiedValues = null,

    /// The weekly time range, in Universal Coordinated Time (UTC), during which
    /// system
    /// maintenance can occur.
    ///
    /// Format:
    /// `
    /// **:HH:MM-**:HH:MM`
    ///
    /// For the day values, use `mon` | `tue` | `wed` |
    /// `thu` | `fri` | `sat` | `sun`
    ///
    /// For example, `sun:09:32-sun:10:02`
    preferred_maintenance_window: ?[]const u8 = null,

    /// Whether the cluster can be accessed from a public network.
    publicly_accessible: ?bool = null,

    /// Information about the resize operation for the cluster.
    resize_info: ?AwsRedshiftClusterResizeInfo = null,

    /// Information about the status of a cluster restore action. Only applies to a
    /// cluster that
    /// was created by restoring a snapshot.
    restore_status: ?AwsRedshiftClusterRestoreStatus = null,

    /// A unique identifier for the cluster snapshot schedule.
    snapshot_schedule_identifier: ?[]const u8 = null,

    /// The current state of the cluster snapshot schedule.
    ///
    /// Valid values: `MODIFYING` | `ACTIVE` | `FAILED`
    snapshot_schedule_state: ?[]const u8 = null,

    /// The identifier of the VPC that the cluster is in, if the cluster is in a
    /// VPC.
    vpc_id: ?[]const u8 = null,

    /// The list of VPC security groups that the cluster belongs to, if the cluster
    /// is in a
    /// VPC.
    vpc_security_groups: ?[]const AwsRedshiftClusterVpcSecurityGroup = null,

    pub const json_field_names = .{
        .allow_version_upgrade = "AllowVersionUpgrade",
        .automated_snapshot_retention_period = "AutomatedSnapshotRetentionPeriod",
        .availability_zone = "AvailabilityZone",
        .cluster_availability_status = "ClusterAvailabilityStatus",
        .cluster_create_time = "ClusterCreateTime",
        .cluster_identifier = "ClusterIdentifier",
        .cluster_nodes = "ClusterNodes",
        .cluster_parameter_groups = "ClusterParameterGroups",
        .cluster_public_key = "ClusterPublicKey",
        .cluster_revision_number = "ClusterRevisionNumber",
        .cluster_security_groups = "ClusterSecurityGroups",
        .cluster_snapshot_copy_status = "ClusterSnapshotCopyStatus",
        .cluster_status = "ClusterStatus",
        .cluster_subnet_group_name = "ClusterSubnetGroupName",
        .cluster_version = "ClusterVersion",
        .db_name = "DBName",
        .deferred_maintenance_windows = "DeferredMaintenanceWindows",
        .elastic_ip_status = "ElasticIpStatus",
        .elastic_resize_number_of_node_options = "ElasticResizeNumberOfNodeOptions",
        .encrypted = "Encrypted",
        .endpoint = "Endpoint",
        .enhanced_vpc_routing = "EnhancedVpcRouting",
        .expected_next_snapshot_schedule_time = "ExpectedNextSnapshotScheduleTime",
        .expected_next_snapshot_schedule_time_status = "ExpectedNextSnapshotScheduleTimeStatus",
        .hsm_status = "HsmStatus",
        .iam_roles = "IamRoles",
        .kms_key_id = "KmsKeyId",
        .logging_status = "LoggingStatus",
        .maintenance_track_name = "MaintenanceTrackName",
        .manual_snapshot_retention_period = "ManualSnapshotRetentionPeriod",
        .master_username = "MasterUsername",
        .next_maintenance_window_start_time = "NextMaintenanceWindowStartTime",
        .node_type = "NodeType",
        .number_of_nodes = "NumberOfNodes",
        .pending_actions = "PendingActions",
        .pending_modified_values = "PendingModifiedValues",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .publicly_accessible = "PubliclyAccessible",
        .resize_info = "ResizeInfo",
        .restore_status = "RestoreStatus",
        .snapshot_schedule_identifier = "SnapshotScheduleIdentifier",
        .snapshot_schedule_state = "SnapshotScheduleState",
        .vpc_id = "VpcId",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};
