const CustomLaunchTemplate = @import("custom_launch_template.zig").CustomLaunchTemplate;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const InstanceConfig = @import("instance_config.zig").InstanceConfig;
const PurchaseOption = @import("purchase_option.zig").PurchaseOption;
const ScalingConfiguration = @import("scaling_configuration.zig").ScalingConfiguration;
const ComputeNodeGroupSlurmConfiguration = @import("compute_node_group_slurm_configuration.zig").ComputeNodeGroupSlurmConfiguration;
const SpotOptions = @import("spot_options.zig").SpotOptions;
const ComputeNodeGroupStatus = @import("compute_node_group_status.zig").ComputeNodeGroupStatus;

/// A compute node group associated with a cluster.
pub const ComputeNodeGroup = struct {
    /// The ID of the Amazon Machine Image (AMI) that PCS uses to launch instances.
    /// If not provided, PCS uses the AMI ID specified in the custom launch
    /// template.
    ami_id: ?[]const u8,

    /// The unique Amazon Resource Name (ARN) of the compute node group.
    arn: []const u8,

    /// The ID of the cluster of the compute node group.
    cluster_id: []const u8,

    /// The date and time the resource was created.
    created_at: i64,

    custom_launch_template: CustomLaunchTemplate,

    /// The list of errors that occurred during compute node group provisioning.
    error_info: ?[]const ErrorInfo,

    /// The Amazon Resource Name (ARN) of the IAM instance profile used to pass an
    /// IAM role when launching EC2 instances. The role contained in your instance
    /// profile must have the `pcs:RegisterComputeNodeGroupInstance` permission and
    /// the role name must start with `AWSPCS` or must have the path `/aws-pcs/`.
    /// For more information, see [IAM instance profiles for
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/security-instance-profiles.html) in the *PCS User Guide*.
    iam_instance_profile_arn: []const u8,

    /// The generated unique ID of the compute node group.
    id: []const u8,

    /// A list of EC2 instance configurations that PCS can provision in the compute
    /// node group.
    instance_configs: []const InstanceConfig,

    /// The date and time the resource was modified.
    modified_at: i64,

    /// The name that identifies the compute node group.
    name: []const u8,

    /// Specifies how EC2 instances are purchased on your behalf. PCS supports
    /// On-Demand Instances, Spot Instances, and Amazon EC2 Capacity Blocks for ML.
    /// For more information, see [Amazon EC2 billing and purchasing
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-purchasing-options.html) in the *Amazon Elastic Compute Cloud User Guide*. For more information about PCS support for Capacity Blocks, see [Using Amazon EC2 Capacity Blocks for ML with PCS](https://docs.aws.amazon.com/pcs/latest/userguide/capacity-blocks.html) in the *PCS User Guide*. If you don't provide this option, it defaults to On-Demand.
    purchase_option: ?PurchaseOption,

    scaling_configuration: ScalingConfiguration,

    slurm_configuration: ?ComputeNodeGroupSlurmConfiguration,

    spot_options: ?SpotOptions,

    /// The provisioning status of the compute node group.
    ///
    /// The provisioning status doesn't indicate the overall health of the compute
    /// node group.
    ///
    /// The resource enters the `SUSPENDING` and `SUSPENDED` states when the
    /// scheduler is beyond end of life and we have suspended the cluster. When in
    /// these states, you can't use the cluster. The cluster controller is down and
    /// all compute instances are terminated. The resources still count toward your
    /// service quotas. You can delete a resource if its status is `SUSPENDED`. For
    /// more information, see [Frequently asked questions about Slurm versions in
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/slurm-versions_faq.html) in the *PCS User Guide*.
    status: ComputeNodeGroupStatus,

    /// The list of subnet IDs where instances are provisioned by the compute node
    /// group. The subnets must be in the same VPC as the cluster.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .ami_id = "amiId",
        .arn = "arn",
        .cluster_id = "clusterId",
        .created_at = "createdAt",
        .custom_launch_template = "customLaunchTemplate",
        .error_info = "errorInfo",
        .iam_instance_profile_arn = "iamInstanceProfileArn",
        .id = "id",
        .instance_configs = "instanceConfigs",
        .modified_at = "modifiedAt",
        .name = "name",
        .purchase_option = "purchaseOption",
        .scaling_configuration = "scalingConfiguration",
        .slurm_configuration = "slurmConfiguration",
        .spot_options = "spotOptions",
        .status = "status",
        .subnet_ids = "subnetIds",
    };
};
