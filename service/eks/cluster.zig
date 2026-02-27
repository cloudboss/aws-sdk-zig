const aws = @import("aws");

const AccessConfigResponse = @import("access_config_response.zig").AccessConfigResponse;
const Certificate = @import("certificate.zig").Certificate;
const ComputeConfigResponse = @import("compute_config_response.zig").ComputeConfigResponse;
const ConnectorConfigResponse = @import("connector_config_response.zig").ConnectorConfigResponse;
const ControlPlaneScalingConfig = @import("control_plane_scaling_config.zig").ControlPlaneScalingConfig;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const ClusterHealth = @import("cluster_health.zig").ClusterHealth;
const Identity = @import("identity.zig").Identity;
const KubernetesNetworkConfigResponse = @import("kubernetes_network_config_response.zig").KubernetesNetworkConfigResponse;
const Logging = @import("logging.zig").Logging;
const OutpostConfigResponse = @import("outpost_config_response.zig").OutpostConfigResponse;
const RemoteNetworkConfigResponse = @import("remote_network_config_response.zig").RemoteNetworkConfigResponse;
const VpcConfigResponse = @import("vpc_config_response.zig").VpcConfigResponse;
const ClusterStatus = @import("cluster_status.zig").ClusterStatus;
const StorageConfigResponse = @import("storage_config_response.zig").StorageConfigResponse;
const UpgradePolicyResponse = @import("upgrade_policy_response.zig").UpgradePolicyResponse;
const ZonalShiftConfigResponse = @import("zonal_shift_config_response.zig").ZonalShiftConfigResponse;

/// An object representing an Amazon EKS cluster.
pub const Cluster = struct {
    /// The access configuration for the cluster.
    access_config: ?AccessConfigResponse,

    /// The Amazon Resource Name (ARN) of the cluster.
    arn: ?[]const u8,

    /// The `certificate-authority-data` for your cluster.
    certificate_authority: ?Certificate,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8,

    /// Indicates the current configuration of the compute capability on your EKS
    /// Auto Mode
    /// cluster. For example, if the capability is enabled or disabled. If the
    /// compute
    /// capability is enabled, EKS Auto Mode will create and delete EC2 Managed
    /// Instances in
    /// your Amazon Web Services account. For more information, see EKS Auto Mode
    /// compute capability in the
    /// *Amazon EKS User Guide*.
    compute_config: ?ComputeConfigResponse,

    /// The configuration used to connect to a cluster for registration.
    connector_config: ?ConnectorConfigResponse,

    /// The control plane scaling tier configuration. For more information, see EKS
    /// Provisioned Control Plane in the Amazon EKS User Guide.
    control_plane_scaling_config: ?ControlPlaneScalingConfig,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64,

    /// The current deletion protection setting for the cluster. When `true`,
    /// deletion protection is enabled and the cluster cannot be deleted until
    /// protection is
    /// disabled. When `false`, the cluster can be deleted normally. This setting
    /// only applies to clusters in an active state.
    deletion_protection: ?bool,

    /// The encryption configuration for the cluster.
    encryption_config: ?[]const EncryptionConfig,

    /// The endpoint for your Kubernetes API server.
    endpoint: ?[]const u8,

    /// An object representing the health of your Amazon EKS cluster.
    health: ?ClusterHealth,

    /// The ID of your local Amazon EKS cluster on an Amazon Web Services Outpost.
    /// This property isn't available
    /// for an Amazon EKS cluster on the Amazon Web Services cloud.
    id: ?[]const u8,

    /// The identity provider information for the cluster.
    identity: ?Identity,

    /// The Kubernetes network configuration for the cluster.
    kubernetes_network_config: ?KubernetesNetworkConfigResponse,

    /// The logging configuration for your cluster.
    logging: ?Logging,

    /// The name of your cluster.
    name: ?[]const u8,

    /// An object representing the configuration of your local Amazon EKS cluster on
    /// an Amazon Web Services
    /// Outpost. This object isn't available for clusters on the Amazon Web Services
    /// cloud.
    outpost_config: ?OutpostConfigResponse,

    /// The platform version of your Amazon EKS cluster. For more information about
    /// clusters
    /// deployed on the Amazon Web Services Cloud, see [Platform
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/platform-versions.html) in the *
    /// Amazon EKS User Guide*
    /// . For more information
    /// about local clusters deployed on an Outpost, see [Amazon EKS local cluster
    /// platform
    /// versions](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-platform-versions.html) in the
    /// *
    /// Amazon EKS User Guide*
    /// .
    platform_version: ?[]const u8,

    /// The configuration in the cluster for EKS Hybrid Nodes. You can add, change,
    /// or remove this
    /// configuration after the cluster is created.
    remote_network_config: ?RemoteNetworkConfigResponse,

    /// The VPC configuration used by the cluster control plane. Amazon EKS VPC
    /// resources have
    /// specific requirements to work properly with Kubernetes. For more
    /// information, see [Cluster VPC
    /// considerations](https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html) and [Cluster security group considerations](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the
    /// *Amazon EKS User Guide*.
    resources_vpc_config: ?VpcConfigResponse,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the Kubernetes control plane
    /// to make calls to Amazon Web Services API operations on your behalf.
    role_arn: ?[]const u8,

    /// The current status of the cluster.
    status: ?ClusterStatus,

    /// Indicates the current configuration of the block storage capability on your
    /// EKS Auto
    /// Mode cluster. For example, if the capability is enabled or disabled. If the
    /// block
    /// storage capability is enabled, EKS Auto Mode will create and delete EBS
    /// volumes in your
    /// Amazon Web Services account. For more information, see EKS Auto Mode block
    /// storage capability in the
    /// *Amazon EKS User Guide*.
    storage_config: ?StorageConfigResponse,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry,

    /// This value indicates if extended support is enabled or disabled for the
    /// cluster.
    ///
    /// [Learn more about EKS Extended Support in the *Amazon EKS User
    /// Guide*.](https://docs.aws.amazon.com/eks/latest/userguide/extended-support-control.html)
    upgrade_policy: ?UpgradePolicyResponse,

    /// The Kubernetes server version for the cluster.
    version: ?[]const u8,

    /// The configuration for zonal shift for the cluster.
    zonal_shift_config: ?ZonalShiftConfigResponse,

    pub const json_field_names = .{
        .access_config = "accessConfig",
        .arn = "arn",
        .certificate_authority = "certificateAuthority",
        .client_request_token = "clientRequestToken",
        .compute_config = "computeConfig",
        .connector_config = "connectorConfig",
        .control_plane_scaling_config = "controlPlaneScalingConfig",
        .created_at = "createdAt",
        .deletion_protection = "deletionProtection",
        .encryption_config = "encryptionConfig",
        .endpoint = "endpoint",
        .health = "health",
        .id = "id",
        .identity = "identity",
        .kubernetes_network_config = "kubernetesNetworkConfig",
        .logging = "logging",
        .name = "name",
        .outpost_config = "outpostConfig",
        .platform_version = "platformVersion",
        .remote_network_config = "remoteNetworkConfig",
        .resources_vpc_config = "resourcesVpcConfig",
        .role_arn = "roleArn",
        .status = "status",
        .storage_config = "storageConfig",
        .tags = "tags",
        .upgrade_policy = "upgradePolicy",
        .version = "version",
        .zonal_shift_config = "zonalShiftConfig",
    };
};
