const aws = @import("aws");

const CreateAccessConfigRequest = @import("create_access_config_request.zig").CreateAccessConfigRequest;
const ComputeConfigRequest = @import("compute_config_request.zig").ComputeConfigRequest;
const ControlPlaneScalingConfig = @import("control_plane_scaling_config.zig").ControlPlaneScalingConfig;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const KubernetesNetworkConfigRequest = @import("kubernetes_network_config_request.zig").KubernetesNetworkConfigRequest;
const Logging = @import("logging.zig").Logging;
const OutpostConfigRequest = @import("outpost_config_request.zig").OutpostConfigRequest;
const RemoteNetworkConfigRequest = @import("remote_network_config_request.zig").RemoteNetworkConfigRequest;
const VpcConfigRequest = @import("vpc_config_request.zig").VpcConfigRequest;
const StorageConfigRequest = @import("storage_config_request.zig").StorageConfigRequest;
const UpgradePolicyRequest = @import("upgrade_policy_request.zig").UpgradePolicyRequest;
const ZonalShiftConfigRequest = @import("zonal_shift_config_request.zig").ZonalShiftConfigRequest;

pub const CreateClusterRequest = struct {
    /// The access configuration for the cluster.
    access_config: ?CreateAccessConfigRequest = null,

    /// If you set this value to `False` when creating a cluster, the default
    /// networking add-ons will not be installed.
    ///
    /// The default networking add-ons include `vpc-cni`, `coredns`, and
    /// `kube-proxy`.
    ///
    /// Use this option when you plan to install third-party alternative add-ons or
    /// self-manage the default networking add-ons.
    bootstrap_self_managed_addons: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// Enable or disable the compute capability of EKS Auto Mode when creating your
    /// EKS Auto
    /// Mode cluster. If the compute capability is enabled, EKS Auto Mode will
    /// create and delete
    /// EC2 Managed Instances in your Amazon Web Services account
    compute_config: ?ComputeConfigRequest = null,

    /// The control plane scaling tier configuration. For more information, see EKS
    /// Provisioned Control Plane in the Amazon EKS User Guide.
    control_plane_scaling_config: ?ControlPlaneScalingConfig = null,

    /// Indicates whether to enable deletion protection for the cluster. When
    /// enabled, the cluster
    /// cannot be deleted unless deletion protection is first disabled. This helps
    /// prevent
    /// accidental cluster deletion. Default value is `false`.
    deletion_protection: ?bool = null,

    /// The encryption configuration for the cluster.
    encryption_config: ?[]const EncryptionConfig = null,

    /// The Kubernetes network configuration for the cluster.
    kubernetes_network_config: ?KubernetesNetworkConfigRequest = null,

    /// Enable or disable exporting the Kubernetes control plane logs for your
    /// cluster to CloudWatch Logs .
    /// By default, cluster control plane logs aren't exported to CloudWatch Logs .
    /// For more information,
    /// see [Amazon EKS
    /// Cluster control plane
    /// logs](https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// CloudWatch Logs ingestion, archive storage, and data scanning rates apply to
    /// exported
    /// control plane logs. For more information, see [CloudWatch
    /// Pricing](http://aws.amazon.com/cloudwatch/pricing/).
    logging: ?Logging = null,

    /// The unique name to give to your cluster. The name can contain only
    /// alphanumeric characters (case-sensitive),
    /// hyphens, and underscores. It must start with an alphanumeric character and
    /// can't be longer than
    /// 100 characters. The name must be unique within the Amazon Web Services
    /// Region and Amazon Web Services account that you're
    /// creating the cluster in.
    name: []const u8,

    /// An object representing the configuration of your local Amazon EKS cluster on
    /// an Amazon Web Services
    /// Outpost. Before creating a local cluster on an Outpost, review [Local
    /// clusters
    /// for Amazon EKS on Amazon Web Services
    /// Outposts](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-local-cluster-overview.html) in the *Amazon EKS User Guide*. This object isn't
    /// available for creating Amazon EKS clusters on the Amazon Web Services cloud.
    outpost_config: ?OutpostConfigRequest = null,

    /// The configuration in the cluster for EKS Hybrid Nodes. You can add, change,
    /// or remove this
    /// configuration after the cluster is created.
    remote_network_config: ?RemoteNetworkConfigRequest = null,

    /// The VPC configuration that's used by the cluster control plane. Amazon EKS
    /// VPC resources
    /// have specific requirements to work properly with Kubernetes. For more
    /// information, see [Cluster VPC
    /// Considerations](https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) and [Cluster Security Group Considerations](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the
    /// *Amazon EKS User Guide*. You must specify at least two subnets. You can
    /// specify up to five
    /// security groups. However, we recommend that you use a dedicated security
    /// group for your
    /// cluster control plane.
    resources_vpc_config: VpcConfigRequest,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the Kubernetes control plane
    /// to make calls to Amazon Web Services API operations on your behalf. For more
    /// information, see [Amazon EKS Service
    /// IAM
    /// Role](https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html) in the *
    /// Amazon EKS User Guide*
    /// .
    role_arn: []const u8,

    /// Enable or disable the block storage capability of EKS Auto Mode when
    /// creating your EKS
    /// Auto Mode cluster. If the block storage capability is enabled, EKS Auto Mode
    /// will create
    /// and delete EBS volumes in your Amazon Web Services account.
    storage_config: ?StorageConfigRequest = null,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// New clusters, by default, have extended support enabled. You can disable
    /// extended
    /// support when creating a cluster by setting this value to `STANDARD`.
    upgrade_policy: ?UpgradePolicyRequest = null,

    /// The desired Kubernetes version for your cluster. If you don't specify a
    /// value here, the
    /// default version available in Amazon EKS is used.
    ///
    /// The default version might not be the latest version available.
    version: ?[]const u8 = null,

    /// Enable or disable ARC zonal shift for the cluster. If zonal shift is
    /// enabled, Amazon Web Services
    /// configures zonal autoshift for the cluster.
    ///
    /// Zonal shift is a feature of Amazon Application Recovery Controller (ARC).
    /// ARC zonal shift is designed to be a
    /// temporary measure that allows you to move traffic for a resource away from
    /// an impaired
    /// AZ until the zonal shift expires or you cancel it. You can extend the zonal
    /// shift if
    /// necessary.
    ///
    /// You can start a zonal shift for an Amazon EKS cluster, or you can allow
    /// Amazon Web Services to do it for
    /// you by enabling *zonal autoshift*. This shift updates the flow of
    /// east-to-west network traffic in your cluster to only consider network
    /// endpoints for Pods
    /// running on worker nodes in healthy AZs. Additionally, any ALB or NLB
    /// handling ingress
    /// traffic for applications in your Amazon EKS cluster will automatically route
    /// traffic to
    /// targets in the healthy AZs. For more information about zonal shift in EKS,
    /// see [Learn about
    /// Amazon Application Recovery Controller (ARC) Zonal Shift in Amazon
    /// EKS](https://docs.aws.amazon.com/eks/latest/userguide/zone-shift.html) in
    /// the
    /// *
    /// Amazon EKS User Guide*
    /// .
    zonal_shift_config: ?ZonalShiftConfigRequest = null,

    pub const json_field_names = .{
        .access_config = "accessConfig",
        .bootstrap_self_managed_addons = "bootstrapSelfManagedAddons",
        .client_request_token = "clientRequestToken",
        .compute_config = "computeConfig",
        .control_plane_scaling_config = "controlPlaneScalingConfig",
        .deletion_protection = "deletionProtection",
        .encryption_config = "encryptionConfig",
        .kubernetes_network_config = "kubernetesNetworkConfig",
        .logging = "logging",
        .name = "name",
        .outpost_config = "outpostConfig",
        .remote_network_config = "remoteNetworkConfig",
        .resources_vpc_config = "resourcesVpcConfig",
        .role_arn = "roleArn",
        .storage_config = "storageConfig",
        .tags = "tags",
        .upgrade_policy = "upgradePolicy",
        .version = "version",
        .zonal_shift_config = "zonalShiftConfig",
    };
};
