const ClusterStatus = @import("cluster_status.zig").ClusterStatus;

/// Contains information about the Amazon EKS cluster involved in a GuardDuty
/// finding, including cluster identification, status, and network
/// configuration.
pub const EksCluster = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the Amazon EKS
    /// cluster involved in the finding.
    arn: ?[]const u8 = null,

    /// The timestamp indicating when the Amazon EKS cluster was created, in UTC
    /// format.
    created_at: ?i64 = null,

    /// A list of unique identifiers for the Amazon EC2 instances that serve as
    /// worker nodes in the Amazon EKS cluster.
    ec_2_instance_uids: ?[]const []const u8 = null,

    /// The current status of the Amazon EKS cluster.
    status: ?ClusterStatus = null,

    /// The ID of the Amazon Virtual Private Cloud (Amazon VPC) associated with the
    /// Amazon EKS cluster.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .ec_2_instance_uids = "Ec2InstanceUids",
        .status = "Status",
        .vpc_id = "VpcId",
    };
};
