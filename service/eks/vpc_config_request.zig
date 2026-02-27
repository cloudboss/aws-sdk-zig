/// An object representing the VPC configuration to use for an Amazon EKS
/// cluster.
pub const VpcConfigRequest = struct {
    /// Set this value to `true` to enable private access for your cluster's
    /// Kubernetes
    /// API server endpoint. If you enable private access, Kubernetes API requests
    /// from within your
    /// cluster's VPC use the private VPC endpoint. The default value for this
    /// parameter is
    /// `false`, which disables private access for your Kubernetes API server. If
    /// you
    /// disable private access and you have nodes or Fargate pods in the cluster,
    /// then
    /// ensure that `publicAccessCidrs` includes the necessary CIDR blocks for
    /// communication with the nodes or Fargate pods. For more information, see
    /// [Cluster
    /// API server
    /// endpoint](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the *
    /// Amazon EKS User Guide*
    /// .
    endpoint_private_access: ?bool,

    /// Set this value to `false` to disable public access to your cluster's
    /// Kubernetes
    /// API server endpoint. If you disable public access, your cluster's Kubernetes
    /// API server can
    /// only receive requests from within the cluster VPC. The default value for
    /// this parameter
    /// is `true`, which enables public access for your Kubernetes API server. The
    /// endpoint domain name and IP address family depends on the value of the
    /// `ipFamily` for the cluster. For more information, see [Cluster API
    /// server
    /// endpoint](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html) in the *
    /// Amazon EKS User Guide*
    /// .
    endpoint_public_access: ?bool,

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

    /// Specify one or more security groups for the cross-account elastic network
    /// interfaces
    /// that Amazon EKS creates to use that allow communication between your nodes
    /// and the Kubernetes
    /// control plane. If you don't specify any security groups, then familiarize
    /// yourself with
    /// the difference between Amazon EKS defaults for clusters deployed with
    /// Kubernetes. For more
    /// information, see [Amazon EKS security group
    /// considerations](https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html) in the *
    /// Amazon EKS User Guide*
    /// .
    security_group_ids: ?[]const []const u8,

    /// Specify subnets for your Amazon EKS nodes. Amazon EKS creates cross-account
    /// elastic network
    /// interfaces in these subnets to allow communication between your nodes and
    /// the Kubernetes
    /// control plane.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .endpoint_private_access = "endpointPrivateAccess",
        .endpoint_public_access = "endpointPublicAccess",
        .public_access_cidrs = "publicAccessCidrs",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
