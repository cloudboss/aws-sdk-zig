/// Information about the VPC configuration used by the cluster control plane.
pub const AwsEksClusterResourcesVpcConfigDetails = struct {
    /// Indicates whether the Amazon EKS public API server endpoint is turned on. If
    /// the Amazon EKS public API
    /// server endpoint is turned off, your cluster's Kubernetes API server can only
    /// receive requests that originate from within
    /// the cluster VPC.
    endpoint_public_access: ?bool,

    /// The security groups that are associated with the cross-account elastic
    /// network interfaces that are used to allow communication between your nodes
    /// and the Amazon EKS control plane.
    security_group_ids: ?[]const []const u8,

    /// The subnets that are associated with the cluster.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .endpoint_public_access = "EndpointPublicAccess",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
