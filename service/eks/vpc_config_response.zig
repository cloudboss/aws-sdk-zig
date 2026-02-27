/// An object representing an Amazon EKS cluster VPC configuration response.
pub const VpcConfigResponse = struct {
    /// The cluster security group that was created by Amazon EKS for the cluster.
    /// Managed node
    /// groups use this security group for control-plane-to-data-plane
    /// communication.
    cluster_security_group_id: ?[]const u8,

    /// This parameter indicates whether the Amazon EKS private API server endpoint
    /// is enabled. If
    /// the Amazon EKS private API server endpoint is enabled, Kubernetes API
    /// requests that originate from
    /// within your cluster's VPC use the private VPC endpoint instead of traversing
    /// the
    /// internet. If this value is disabled and you have nodes or Fargate pods in
    /// the
    /// cluster, then ensure that `publicAccessCidrs` includes the necessary CIDR
    /// blocks for communication with the nodes or Fargate pods. For more
    /// information, see
    /// [Cluster
    /// API server
    /// endpoint](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the *
    /// Amazon EKS User Guide*
    /// .
    endpoint_private_access: bool = false,

    /// Whether the public API server endpoint is enabled.
    endpoint_public_access: bool = false,

    /// The CIDR blocks that are allowed access to your cluster's public Kubernetes
    /// API server
    /// endpoint. Communication to the endpoint from addresses outside of the CIDR
    /// blocks that
    /// you specify is denied. The default value is `0.0.0.0/0` and additionally
    /// `::/0` for dual-stack `IPv6` clusters. If you've disabled private
    /// endpoint access, make sure that you specify the necessary CIDR blocks for
    /// every node and
    /// Fargate `Pod` in the cluster. For more information, see [Cluster
    /// API server
    /// endpoint](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the *
    /// Amazon EKS User Guide*
    /// .
    ///
    /// Note that the public endpoints are dual-stack for only `IPv6` clusters that
    /// are made after October 2024. You can't add `IPv6` CIDR blocks to
    /// `IPv4` clusters or `IPv6` clusters that were made before
    /// October 2024.
    public_access_cidrs: ?[]const []const u8,

    /// The security groups associated with the cross-account elastic network
    /// interfaces that
    /// are used to allow communication between your nodes and the Kubernetes
    /// control plane.
    security_group_ids: ?[]const []const u8,

    /// The subnets associated with your cluster.
    subnet_ids: ?[]const []const u8,

    /// The VPC associated with your cluster.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .cluster_security_group_id = "clusterSecurityGroupId",
        .endpoint_private_access = "endpointPrivateAccess",
        .endpoint_public_access = "endpointPublicAccess",
        .public_access_cidrs = "publicAccessCidrs",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
