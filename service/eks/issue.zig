const NodegroupIssueCode = @import("nodegroup_issue_code.zig").NodegroupIssueCode;

/// An object representing an issue with an Amazon EKS resource.
pub const Issue = struct {
    /// A brief description of the error.
    ///
    /// * **AccessDenied**: Amazon EKS or one or more of your
    /// managed nodes is failing to authenticate or authorize with your Kubernetes
    /// cluster
    /// API server.
    ///
    /// * **AsgInstanceLaunchFailures**: Your Auto Scaling group is
    /// experiencing failures while attempting to launch instances.
    ///
    /// * **AutoScalingGroupNotFound**: We couldn't find
    /// the Auto Scaling group associated with the managed node group. You may be
    /// able to
    /// recreate an Auto Scaling group with the same settings to recover.
    ///
    /// * **ClusterUnreachable**: Amazon EKS or one or more of
    /// your managed nodes is unable to to communicate with your Kubernetes cluster
    /// API
    /// server. This can happen if there are network disruptions or if API servers
    /// are
    /// timing out processing requests.
    ///
    /// * **Ec2InstanceTypeDoesNotExist**: One or more of
    /// the supplied Amazon EC2 instance types do not exist. Amazon EKS checked for
    /// the
    /// instance types that you provided in this Amazon Web Services Region, and one
    /// or more aren't
    /// available.
    ///
    /// * **Ec2LaunchTemplateNotFound**: We couldn't find
    /// the Amazon EC2 launch template for your managed node group. You may be able
    /// to
    /// recreate a launch template with the same settings to recover.
    ///
    /// * **Ec2LaunchTemplateVersionMismatch**: The Amazon EC2
    /// launch template version for your managed node group does not match the
    /// version
    /// that Amazon EKS created. You may be able to revert to the version that
    /// Amazon EKS created
    /// to recover.
    ///
    /// * **Ec2SecurityGroupDeletionFailure**: We could not
    /// delete the remote access security group for your managed node group. Remove
    /// any
    /// dependencies from the security group.
    ///
    /// * **Ec2SecurityGroupNotFound**: We couldn't find
    /// the cluster security group for the cluster. You must recreate your
    /// cluster.
    ///
    /// * **Ec2SubnetInvalidConfiguration**: One or more
    /// Amazon EC2 subnets specified for a node group do not automatically assign
    /// public IP
    /// addresses to instances launched into it. If you want your instances to be
    /// assigned a public IP address, then you need to enable the `auto-assign
    /// public IP address` setting for the subnet. See [Modifying
    /// the public `IPv4` addressing attribute for your
    /// subnet](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html#subnet-public-ip) in
    /// the *Amazon VPC User Guide*.
    ///
    /// * **IamInstanceProfileNotFound**: We couldn't find
    /// the IAM instance profile for your managed node group. You may be able to
    /// recreate an instance profile with the same settings to recover.
    ///
    /// * **IamNodeRoleNotFound**: We couldn't find the
    /// IAM role for your managed node group. You may be able to recreate an IAM
    /// role with the same settings to recover.
    ///
    /// * **InstanceLimitExceeded**: Your Amazon Web Services account is
    /// unable to launch any more instances of the specified instance type. You may
    /// be
    /// able to request an Amazon EC2 instance limit increase to recover.
    ///
    /// * **InsufficientFreeAddresses**: One or more of the
    /// subnets associated with your managed node group does not have enough
    /// available
    /// IP addresses for new nodes.
    ///
    /// * **InternalFailure**: These errors are usually
    /// caused by an Amazon EKS server-side issue.
    ///
    /// * **NodeCreationFailure**: Your launched instances
    /// are unable to register with your Amazon EKS cluster. Common causes of this
    /// failure
    /// are insufficient [node IAM
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html)
    /// permissions or lack of outbound internet access for the nodes.
    code: ?NodegroupIssueCode = null,

    /// The error message associated with the issue.
    message: ?[]const u8 = null,

    /// The Amazon Web Services resources that are afflicted by this issue.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .resource_ids = "resourceIds",
    };
};
