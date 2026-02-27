const AwsEksClusterLoggingClusterLoggingDetails = @import("aws_eks_cluster_logging_cluster_logging_details.zig").AwsEksClusterLoggingClusterLoggingDetails;

/// The logging configuration for an Amazon EKS cluster.
pub const AwsEksClusterLoggingDetails = struct {
    /// Cluster logging configurations.
    cluster_logging: ?[]const AwsEksClusterLoggingClusterLoggingDetails,

    pub const json_field_names = .{
        .cluster_logging = "ClusterLogging",
    };
};
