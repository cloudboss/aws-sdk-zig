const AwsEksWorkloadInfo = @import("aws_eks_workload_info.zig").AwsEksWorkloadInfo;

/// The metadata for an Amazon EKS pod where an Amazon ECR image is in
/// use.
pub const AwsEksMetadataDetails = struct {
    /// The namespace for an Amazon EKS cluster.
    namespace: ?[]const u8 = null,

    /// The list of workloads.
    workload_info_list: ?[]const AwsEksWorkloadInfo = null,

    pub const json_field_names = .{
        .namespace = "namespace",
        .workload_info_list = "workloadInfoList",
    };
};
