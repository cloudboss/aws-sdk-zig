const Application = @import("application.zig").Application;
const Configuration = @import("configuration.zig").Configuration;
const Ec2InstanceAttributes = @import("ec_2_instance_attributes.zig").Ec2InstanceAttributes;
const InstanceCollectionType = @import("instance_collection_type.zig").InstanceCollectionType;
const KerberosAttributes = @import("kerberos_attributes.zig").KerberosAttributes;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const PlacementGroupConfig = @import("placement_group_config.zig").PlacementGroupConfig;
const RepoUpgradeOnBoot = @import("repo_upgrade_on_boot.zig").RepoUpgradeOnBoot;
const ScaleDownBehavior = @import("scale_down_behavior.zig").ScaleDownBehavior;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;
const Tag = @import("tag.zig").Tag;

/// The detailed description of the cluster.
pub const Cluster = struct {
    /// The applications installed on this cluster.
    applications: ?[]const Application = null,

    /// An IAM role for automatic scaling policies. The default role is
    /// `EMR_AutoScaling_DefaultRole`. The IAM role provides
    /// permissions that the automatic scaling feature requires to launch and
    /// terminate Amazon EC2 instances in an instance group.
    auto_scaling_role: ?[]const u8 = null,

    /// Specifies whether the cluster should terminate after completing all steps.
    auto_terminate: ?bool = null,

    /// The Amazon Resource Name of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// Applies only to Amazon EMR releases 4.x and later. The list of
    /// configurations
    /// that are supplied to the Amazon EMR cluster.
    configurations: ?[]const Configuration = null,

    /// Available only in Amazon EMR releases 5.7.0 and later. The ID of a custom
    /// Amazon
    /// EBS-backed Linux AMI if the cluster uses a custom AMI.
    custom_ami_id: ?[]const u8 = null,

    /// The IOPS, of the Amazon EBS root device volume of the Linux AMI that is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0
    /// and
    /// later.
    ebs_root_volume_iops: ?i32 = null,

    /// The size, in GiB, of the Amazon EBS root device volume of the Linux AMI that
    /// is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 4.x and
    /// later.
    ebs_root_volume_size: ?i32 = null,

    /// The throughput, in MiB/s, of the Amazon EBS root device volume of the Linux
    /// AMI that is
    /// used for each Amazon EC2 instance. Available in Amazon EMR releases 6.15.0
    /// and
    /// later.
    ebs_root_volume_throughput: ?i32 = null,

    /// Provides information about the Amazon EC2 instances in a cluster grouped by
    /// category. For example, key name, subnet ID, IAM instance profile, and so
    /// on.
    ec_2_instance_attributes: ?Ec2InstanceAttributes = null,

    /// Reserved.
    extended_support: ?bool = null,

    /// The unique identifier for the cluster.
    id: ?[]const u8 = null,

    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    ///
    /// The instance group configuration of the cluster. A value of `INSTANCE_GROUP`
    /// indicates a uniform instance group configuration. A value of
    /// `INSTANCE_FLEET`
    /// indicates an instance fleets configuration.
    instance_collection_type: ?InstanceCollectionType = null,

    /// Attributes for Kerberos configuration when Kerberos authentication is
    /// enabled using a
    /// security configuration. For more information see [Use Kerberos
    /// Authentication](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-kerberos.html)
    /// in the *Amazon EMR Management Guide*.
    kerberos_attributes: ?KerberosAttributes = null,

    /// The KMS key used for encrypting log files. This attribute is only
    /// available with Amazon EMR 5.30.0 and later, excluding Amazon EMR 6.0.0.
    log_encryption_kms_key_id: ?[]const u8 = null,

    /// The path to the Amazon S3 location where logs for this cluster are
    /// stored.
    log_uri: ?[]const u8 = null,

    /// The DNS name of the master node. If the cluster is on a private subnet, this
    /// is the
    /// private DNS name. On a public subnet, this is the public DNS name.
    master_public_dns_name: ?[]const u8 = null,

    /// Contains Cloudwatch log configuration metadata and settings.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The name of the cluster. This parameter can't contain the characters , $, |,
    /// or ` (backtick).
    name: ?[]const u8 = null,

    /// An approximation of the cost of the cluster, represented in m1.small/hours.
    /// This value
    /// is incremented one time for every hour an m1.small instance runs. Larger
    /// instances are
    /// weighted more, so an Amazon EC2 instance that is roughly four times more
    /// expensive
    /// would result in the normalized instance hours being incremented by four.
    /// This result is
    /// only an approximation and does not reflect the actual billing rate.
    normalized_instance_hours: ?i32 = null,

    /// The Amazon Linux release specified in a cluster launch RunJobFlow request.
    /// If no Amazon
    /// Linux release was specified, the default Amazon Linux release is shown in
    /// the
    /// response.
    os_release_label: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Outpost where the cluster is launched.
    outpost_arn: ?[]const u8 = null,

    /// Placement group configured for an Amazon EMR cluster.
    placement_groups: ?[]const PlacementGroupConfig = null,

    /// The Amazon EMR release label, which determines the version of open-source
    /// application packages installed on the cluster. Release labels are in the
    /// form
    /// `emr-x.x.x`, where x.x.x is an Amazon EMR release version such as
    /// `emr-5.14.0`. For more information about Amazon EMR release versions
    /// and included application versions and features, see
    /// [https://docs.aws.amazon.com/emr/latest/ReleaseGuide/](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/). The release label applies only to Amazon EMR
    /// releases version 4.0 and later. Earlier versions use `AmiVersion`.
    release_label: ?[]const u8 = null,

    /// Applies only when `CustomAmiID` is used. Specifies the type of updates that
    /// the Amazon Linux AMI package repositories apply when an instance boots using
    /// the
    /// AMI.
    repo_upgrade_on_boot: ?RepoUpgradeOnBoot = null,

    /// The AMI version requested for this cluster.
    requested_ami_version: ?[]const u8 = null,

    /// The AMI version running on this cluster.
    running_ami_version: ?[]const u8 = null,

    /// The way that individual Amazon EC2 instances terminate when an automatic
    /// scale-in activity occurs or an instance group is resized.
    /// `TERMINATE_AT_INSTANCE_HOUR` indicates that Amazon EMR terminates
    /// nodes at the instance-hour boundary, regardless of when the request to
    /// terminate the
    /// instance was submitted. This option is only available with Amazon EMR 5.1.0
    /// and
    /// later and is the default for clusters created using that version.
    /// `TERMINATE_AT_TASK_COMPLETION` indicates that Amazon EMR adds nodes
    /// to a deny list and drains tasks from nodes before terminating the Amazon EC2
    /// instances, regardless of the instance-hour boundary. With either behavior,
    /// Amazon EMR removes the least active nodes first and blocks instance
    /// termination if it could lead to
    /// HDFS corruption. `TERMINATE_AT_TASK_COMPLETION` is available only in Amazon
    /// EMR releases 4.1.0 and later, and is the default for versions of Amazon EMR
    /// earlier than 5.1.0.
    scale_down_behavior: ?ScaleDownBehavior = null,

    /// The name of the security configuration applied to the cluster.
    security_configuration: ?[]const u8 = null,

    /// The IAM role that Amazon EMR assumes in order to access Amazon Web Services
    /// resources on your behalf.
    service_role: ?[]const u8 = null,

    /// The current status details about the cluster.
    status: ?ClusterStatus = null,

    /// Specifies the number of steps that can be executed concurrently.
    step_concurrency_level: ?i32 = null,

    /// A list of tags associated with a cluster.
    tags: ?[]const Tag = null,

    /// Indicates whether Amazon EMR will lock the cluster to prevent the Amazon EC2
    /// instances from being terminated by an API call or user intervention, or in
    /// the event of a cluster error.
    termination_protected: ?bool = null,

    /// Indicates whether Amazon EMR should gracefully replace Amazon EC2
    /// core instances that have degraded within the cluster.
    unhealthy_node_replacement: ?bool = null,

    /// Indicates whether the cluster is visible to IAM principals in the Amazon Web
    /// Services account associated with the cluster. When `true`, IAM principals in
    /// the Amazon Web Services account can perform Amazon EMR cluster
    /// actions on the cluster that their IAM policies allow. When
    /// `false`, only the IAM principal that created the cluster and
    /// the Amazon Web Services account root user can perform Amazon EMR actions,
    /// regardless
    /// of IAM permissions policies attached to other IAM
    /// principals.
    ///
    /// The default value is `true` if a value is not provided when creating a
    /// cluster using the Amazon EMR API RunJobFlow command, the CLI
    /// [create-cluster](https://docs.aws.amazon.com/cli/latest/reference/emr/create-cluster.html) command, or the Amazon Web Services Management Console.
    visible_to_all_users: ?bool = null,

    pub const json_field_names = .{
        .applications = "Applications",
        .auto_scaling_role = "AutoScalingRole",
        .auto_terminate = "AutoTerminate",
        .cluster_arn = "ClusterArn",
        .configurations = "Configurations",
        .custom_ami_id = "CustomAmiId",
        .ebs_root_volume_iops = "EbsRootVolumeIops",
        .ebs_root_volume_size = "EbsRootVolumeSize",
        .ebs_root_volume_throughput = "EbsRootVolumeThroughput",
        .ec_2_instance_attributes = "Ec2InstanceAttributes",
        .extended_support = "ExtendedSupport",
        .id = "Id",
        .instance_collection_type = "InstanceCollectionType",
        .kerberos_attributes = "KerberosAttributes",
        .log_encryption_kms_key_id = "LogEncryptionKmsKeyId",
        .log_uri = "LogUri",
        .master_public_dns_name = "MasterPublicDnsName",
        .monitoring_configuration = "MonitoringConfiguration",
        .name = "Name",
        .normalized_instance_hours = "NormalizedInstanceHours",
        .os_release_label = "OSReleaseLabel",
        .outpost_arn = "OutpostArn",
        .placement_groups = "PlacementGroups",
        .release_label = "ReleaseLabel",
        .repo_upgrade_on_boot = "RepoUpgradeOnBoot",
        .requested_ami_version = "RequestedAmiVersion",
        .running_ami_version = "RunningAmiVersion",
        .scale_down_behavior = "ScaleDownBehavior",
        .security_configuration = "SecurityConfiguration",
        .service_role = "ServiceRole",
        .status = "Status",
        .step_concurrency_level = "StepConcurrencyLevel",
        .tags = "Tags",
        .termination_protected = "TerminationProtected",
        .unhealthy_node_replacement = "UnhealthyNodeReplacement",
        .visible_to_all_users = "VisibleToAllUsers",
    };
};
