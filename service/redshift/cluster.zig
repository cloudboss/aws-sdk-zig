const AquaConfiguration = @import("aqua_configuration.zig").AquaConfiguration;
const ClusterNode = @import("cluster_node.zig").ClusterNode;
const ClusterParameterGroupStatus = @import("cluster_parameter_group_status.zig").ClusterParameterGroupStatus;
const ClusterSecurityGroupMembership = @import("cluster_security_group_membership.zig").ClusterSecurityGroupMembership;
const ClusterSnapshotCopyStatus = @import("cluster_snapshot_copy_status.zig").ClusterSnapshotCopyStatus;
const DataTransferProgress = @import("data_transfer_progress.zig").DataTransferProgress;
const DeferredMaintenanceWindow = @import("deferred_maintenance_window.zig").DeferredMaintenanceWindow;
const ElasticIpStatus = @import("elastic_ip_status.zig").ElasticIpStatus;
const Endpoint = @import("endpoint.zig").Endpoint;
const HsmStatus = @import("hsm_status.zig").HsmStatus;
const ClusterIamRole = @import("cluster_iam_role.zig").ClusterIamRole;
const SecondaryClusterInfo = @import("secondary_cluster_info.zig").SecondaryClusterInfo;
const PendingModifiedValues = @import("pending_modified_values.zig").PendingModifiedValues;
const ReservedNodeExchangeStatus = @import("reserved_node_exchange_status.zig").ReservedNodeExchangeStatus;
const ResizeInfo = @import("resize_info.zig").ResizeInfo;
const RestoreStatus = @import("restore_status.zig").RestoreStatus;
const ScheduleState = @import("schedule_state.zig").ScheduleState;
const Tag = @import("tag.zig").Tag;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// Describes a cluster.
pub const Cluster = struct {
    /// A boolean value that, if `true`, indicates that major version upgrades
    /// will be applied automatically to the cluster during the maintenance window.
    allow_version_upgrade: ?bool,

    /// This field is retired. Amazon Redshift automatically determines whether to
    /// use AQUA (Advanced Query Accelerator).
    aqua_configuration: ?AquaConfiguration,

    /// The number of days that automatic cluster snapshots are retained.
    automated_snapshot_retention_period: ?i32,

    /// The name of the Availability Zone in which the cluster is located.
    availability_zone: ?[]const u8,

    /// Describes the status of the Availability Zone relocation operation.
    availability_zone_relocation_status: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Glue data catalog associated with the
    /// cluster enabled with Amazon Redshift federated permissions.
    catalog_arn: ?[]const u8,

    /// The availability status of the cluster for queries. Possible values are the
    /// following:
    ///
    /// * Available - The cluster is available for queries.
    ///
    /// * Unavailable - The cluster is not available for queries.
    ///
    /// * Maintenance - The cluster is intermittently available for queries due to
    ///   maintenance activities.
    ///
    /// * Modifying - The cluster is intermittently available for queries due to
    ///   changes that modify the cluster.
    ///
    /// * Failed - The cluster failed and is not available for queries.
    cluster_availability_status: ?[]const u8,

    /// The date and time that the cluster was created.
    cluster_create_time: ?i64,

    /// The unique identifier of the cluster.
    cluster_identifier: ?[]const u8,

    /// The namespace Amazon Resource Name (ARN) of the cluster.
    cluster_namespace_arn: ?[]const u8,

    /// The nodes in the cluster.
    cluster_nodes: ?[]const ClusterNode,

    /// The list of cluster parameter groups that are associated with this cluster.
    /// Each
    /// parameter group in the list is returned with its status.
    cluster_parameter_groups: ?[]const ClusterParameterGroupStatus,

    /// The public key for the cluster.
    cluster_public_key: ?[]const u8,

    /// The specific revision number of the database in the cluster.
    cluster_revision_number: ?[]const u8,

    /// A list of cluster security group that are associated with the cluster. Each
    /// security group is represented by an element that contains
    /// `ClusterSecurityGroup.Name` and `ClusterSecurityGroup.Status`
    /// subelements.
    ///
    /// Cluster security groups are used when the cluster is not created in an
    /// Amazon
    /// Virtual Private Cloud (VPC). Clusters that are created in a VPC use VPC
    /// security groups,
    /// which are listed by the **VpcSecurityGroups** parameter.
    cluster_security_groups: ?[]const ClusterSecurityGroupMembership,

    /// A value that returns the destination region and retention period that are
    /// configured for cross-region snapshot copy.
    cluster_snapshot_copy_status: ?ClusterSnapshotCopyStatus,

    /// The current state of the cluster. Possible values are the following:
    ///
    /// * `available`
    ///
    /// * `available, prep-for-resize`
    ///
    /// * `available, resize-cleanup`
    ///
    /// * `cancelling-resize`
    ///
    /// * `creating`
    ///
    /// * `deleting`
    ///
    /// * `final-snapshot`
    ///
    /// * `hardware-failure`
    ///
    /// * `incompatible-hsm`
    ///
    /// * `incompatible-network`
    ///
    /// * `incompatible-parameters`
    ///
    /// * `incompatible-restore`
    ///
    /// * `modifying`
    ///
    /// * `paused`
    ///
    /// * `rebooting`
    ///
    /// * `renaming`
    ///
    /// * `resizing`
    ///
    /// * `rotating-keys`
    ///
    /// * `storage-full`
    ///
    /// * `updating-hsm`
    cluster_status: ?[]const u8,

    /// The name of the subnet group that is associated with the cluster. This
    /// parameter is
    /// valid only when the cluster is in a VPC.
    cluster_subnet_group_name: ?[]const u8,

    /// The version ID of the Amazon Redshift engine that is running on the cluster.
    cluster_version: ?[]const u8,

    /// The certificate Amazon Resource Name (ARN) for the custom domain name.
    custom_domain_certificate_arn: ?[]const u8,

    /// The expiration date for the certificate associated with the custom domain
    /// name.
    custom_domain_certificate_expiry_date: ?i64,

    /// The custom domain name associated with the cluster.
    custom_domain_name: ?[]const u8,

    data_transfer_progress: ?DataTransferProgress,

    /// The name of the initial database that was created when the cluster was
    /// created.
    /// This same name is returned for the life of the cluster. If an initial
    /// database was not
    /// specified, a database named `dev`dev was created by default.
    db_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the IAM role set as default for the
    /// cluster.
    default_iam_role_arn: ?[]const u8,

    /// Describes a group of `DeferredMaintenanceWindow` objects.
    deferred_maintenance_windows: ?[]const DeferredMaintenanceWindow,

    /// The status of the elastic IP (EIP) address.
    elastic_ip_status: ?ElasticIpStatus,

    /// The number of nodes that you can resize the cluster to with the elastic
    /// resize method.
    elastic_resize_number_of_node_options: ?[]const u8,

    /// A boolean value that, if `true`, indicates that data in the cluster is
    /// encrypted at rest.
    encrypted: ?bool,

    /// The connection endpoint.
    endpoint: ?Endpoint,

    /// An option that specifies whether to create the cluster with enhanced VPC
    /// routing
    /// enabled. To create a cluster that uses enhanced VPC routing, the cluster
    /// must be in a
    /// VPC. For more information, see [Enhanced VPC
    /// Routing](https://docs.aws.amazon.com/redshift/latest/mgmt/enhanced-vpc-routing.html) in
    /// the Amazon Redshift Cluster Management Guide.
    ///
    /// If this option is `true`, enhanced VPC routing is enabled.
    ///
    /// Default: false
    enhanced_vpc_routing: ?bool,

    /// The date and time when the next snapshot is expected to be taken for
    /// clusters with a valid snapshot schedule and backups enabled.
    expected_next_snapshot_schedule_time: ?i64,

    /// The status of next expected snapshot for clusters having a valid snapshot
    /// schedule and backups enabled. Possible values are the following:
    ///
    /// * OnTrack - The next snapshot is expected to be taken on time.
    ///
    /// * Pending - The next snapshot is pending to be taken.
    expected_next_snapshot_schedule_time_status: ?[]const u8,

    /// A boolean value that, if `true`, indicates that the cluster allocates
    /// additional compute resources to run automatic optimization operations.
    ///
    /// Default: false
    extra_compute_for_automatic_optimization: ?[]const u8,

    /// A value that reports whether the Amazon Redshift cluster has finished
    /// applying any
    /// hardware security module (HSM) settings changes specified in a modify
    /// cluster
    /// command.
    ///
    /// Values: active, applying
    hsm_status: ?HsmStatus,

    /// A list of Identity and Access Management (IAM) roles that can be used by the
    /// cluster to access other Amazon Web Services services.
    iam_roles: ?[]const ClusterIamRole,

    /// The IP address type for the cluster. Possible values are `ipv4` and
    /// `dualstack`.
    ip_address_type: ?[]const u8,

    /// The Key Management Service (KMS) key ID of the encryption key used to
    /// encrypt data in the cluster.
    kms_key_id: ?[]const u8,

    /// The status of the lakehouse registration for the cluster. Indicates whether
    /// the cluster is successfully registered with Amazon Redshift federated
    /// permissions.
    lakehouse_registration_status: ?[]const u8,

    /// The name of the maintenance track for the cluster.
    maintenance_track_name: ?[]const u8,

    /// The default number of days to retain a manual snapshot. If the value is -1,
    /// the
    /// snapshot is retained indefinitely. This setting doesn't change the retention
    /// period
    /// of existing snapshots.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    manual_snapshot_retention_period: ?i32,

    /// The Amazon Resource Name (ARN) for the cluster's admin user credentials
    /// secret.
    master_password_secret_arn: ?[]const u8,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// cluster's admin credentials secret.
    master_password_secret_kms_key_id: ?[]const u8,

    /// The admin user name for the cluster. This name is used to connect to the
    /// database
    /// that is specified in the **DBName** parameter.
    master_username: ?[]const u8,

    /// The status of a modify operation, if any, initiated for the cluster.
    modify_status: ?[]const u8,

    /// A boolean value that, if true, indicates that the cluster is deployed in two
    /// Availability Zones.
    multi_az: ?[]const u8,

    /// The secondary compute unit of a cluster, if Multi-AZ deployment is turned
    /// on.
    multi_az_secondary: ?SecondaryClusterInfo,

    /// The date and time in UTC when system maintenance can begin.
    next_maintenance_window_start_time: ?i64,

    /// The node type for the nodes in the cluster.
    node_type: ?[]const u8,

    /// The number of compute nodes in the cluster.
    number_of_nodes: ?i32,

    /// Cluster operations that are waiting to be started.
    pending_actions: ?[]const []const u8,

    /// A value that, if present, indicates that changes to the cluster are pending.
    /// Specific pending changes are identified by subelements.
    pending_modified_values: ?PendingModifiedValues,

    /// The weekly time range, in Universal Coordinated Time (UTC), during which
    /// system
    /// maintenance can occur.
    preferred_maintenance_window: ?[]const u8,

    /// A boolean value that, if `true`, indicates that the cluster can be
    /// accessed from a public network.
    ///
    /// Default: false
    publicly_accessible: ?bool,

    /// The status of the reserved-node exchange request. Statuses include
    /// in-progress and requested.
    reserved_node_exchange_status: ?ReservedNodeExchangeStatus,

    /// Returns the following:
    ///
    /// * AllowCancelResize: a boolean value indicating if the resize operation can
    ///   be
    /// cancelled.
    ///
    /// * ResizeType: Returns ClassicResize
    resize_info: ?ResizeInfo,

    /// A value that describes the status of a cluster restore action. This
    /// parameter
    /// returns null if the cluster was not created by restoring a snapshot.
    restore_status: ?RestoreStatus,

    /// A unique identifier for the cluster snapshot schedule.
    snapshot_schedule_identifier: ?[]const u8,

    /// The current state of the cluster snapshot schedule.
    snapshot_schedule_state: ?ScheduleState,

    /// The list of tags for the cluster.
    tags: ?[]const Tag,

    /// The total storage capacity of the cluster in megabytes.
    total_storage_capacity_in_mega_bytes: ?i64,

    /// The identifier of the VPC the cluster is in, if the cluster is in a VPC.
    vpc_id: ?[]const u8,

    /// A list of Amazon Virtual Private Cloud (Amazon VPC) security groups that are
    /// associated with the cluster. This parameter is returned only if the cluster
    /// is in a
    /// VPC.
    vpc_security_groups: ?[]const VpcSecurityGroupMembership,
};
