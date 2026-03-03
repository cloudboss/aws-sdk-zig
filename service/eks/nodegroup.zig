const aws = @import("aws");

const AMITypes = @import("ami_types.zig").AMITypes;
const CapacityTypes = @import("capacity_types.zig").CapacityTypes;
const NodegroupHealth = @import("nodegroup_health.zig").NodegroupHealth;
const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const NodeRepairConfig = @import("node_repair_config.zig").NodeRepairConfig;
const RemoteAccessConfig = @import("remote_access_config.zig").RemoteAccessConfig;
const NodegroupResources = @import("nodegroup_resources.zig").NodegroupResources;
const NodegroupScalingConfig = @import("nodegroup_scaling_config.zig").NodegroupScalingConfig;
const NodegroupStatus = @import("nodegroup_status.zig").NodegroupStatus;
const Taint = @import("taint.zig").Taint;
const NodegroupUpdateConfig = @import("nodegroup_update_config.zig").NodegroupUpdateConfig;

/// An object representing an Amazon EKS managed node group.
pub const Nodegroup = struct {
    /// If the node group was deployed using a launch template with a custom AMI,
    /// then this is
    /// `CUSTOM`. For node groups that weren't deployed using a launch template,
    /// this is the AMI type that was specified in the node group configuration.
    ami_type: ?AMITypes = null,

    /// The capacity type of your managed node group.
    capacity_type: ?CapacityTypes = null,

    /// The name of your cluster.
    cluster_name: ?[]const u8 = null,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64 = null,

    /// If the node group wasn't deployed with a launch template, then this is the
    /// disk size
    /// in the node group configuration. If the node group was deployed with a
    /// launch template,
    /// then this is `null`.
    disk_size: ?i32 = null,

    /// The health status of the node group. If there are issues with your node
    /// group's
    /// health, they are listed here.
    health: ?NodegroupHealth = null,

    /// If the node group wasn't deployed with a launch template, then this is the
    /// instance
    /// type that is associated with the node group. If the node group was deployed
    /// with a
    /// launch template, then this is `null`.
    instance_types: ?[]const []const u8 = null,

    /// The Kubernetes `labels` applied to the nodes in the node group.
    ///
    /// Only `labels` that are applied with the Amazon EKS API are shown here. There
    /// may be other Kubernetes `labels` applied to the nodes in this group.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// If a launch template was used to create the node group, then this is the
    /// launch
    /// template that was used.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The Unix epoch timestamp for the last modification to the object.
    modified_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) associated with the managed node group.
    nodegroup_arn: ?[]const u8 = null,

    /// The name associated with an Amazon EKS managed node group.
    nodegroup_name: ?[]const u8 = null,

    /// The node auto repair configuration for the node group.
    node_repair_config: ?NodeRepairConfig = null,

    /// The IAM role associated with your node group. The Amazon EKS node `kubelet`
    /// daemon makes calls to Amazon Web Services APIs on your behalf. Nodes receive
    /// permissions for these API
    /// calls through an IAM instance profile and associated policies.
    node_role: ?[]const u8 = null,

    /// If the node group was deployed using a launch template with a custom AMI,
    /// then this is
    /// the AMI ID that was specified in the launch template. For node groups that
    /// weren't
    /// deployed using a launch template, this is the version of the Amazon EKS
    /// optimized AMI that
    /// the node group was deployed with.
    release_version: ?[]const u8 = null,

    /// If the node group wasn't deployed with a launch template, then this is the
    /// remote
    /// access configuration that is associated with the node group. If the node
    /// group was
    /// deployed with a launch template, then this is `null`.
    remote_access: ?RemoteAccessConfig = null,

    /// The resources associated with the node group, such as Auto Scaling groups
    /// and security
    /// groups for remote access.
    resources: ?NodegroupResources = null,

    /// The scaling configuration details for the Auto Scaling group that is
    /// associated with
    /// your node group.
    scaling_config: ?NodegroupScalingConfig = null,

    /// The current status of the managed node group.
    status: ?NodegroupStatus = null,

    /// The subnets that were specified for the Auto Scaling group that is
    /// associated with
    /// your node group.
    subnets: ?[]const []const u8 = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Kubernetes taints to be applied to the nodes in the node group when they
    /// are created.
    /// Effect is one of `No_Schedule`, `Prefer_No_Schedule`, or
    /// `No_Execute`. Kubernetes taints can be used together with tolerations to
    /// control how workloads are scheduled to your nodes. For more information, see
    /// [Node taints on managed node
    /// groups](https://docs.aws.amazon.com/eks/latest/userguide/node-taints-managed-node-groups.html).
    taints: ?[]const Taint = null,

    /// The node group update configuration.
    update_config: ?NodegroupUpdateConfig = null,

    /// The Kubernetes version of the managed node group.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .ami_type = "amiType",
        .capacity_type = "capacityType",
        .cluster_name = "clusterName",
        .created_at = "createdAt",
        .disk_size = "diskSize",
        .health = "health",
        .instance_types = "instanceTypes",
        .labels = "labels",
        .launch_template = "launchTemplate",
        .modified_at = "modifiedAt",
        .nodegroup_arn = "nodegroupArn",
        .nodegroup_name = "nodegroupName",
        .node_repair_config = "nodeRepairConfig",
        .node_role = "nodeRole",
        .release_version = "releaseVersion",
        .remote_access = "remoteAccess",
        .resources = "resources",
        .scaling_config = "scalingConfig",
        .status = "status",
        .subnets = "subnets",
        .tags = "tags",
        .taints = "taints",
        .update_config = "updateConfig",
        .version = "version",
    };
};
