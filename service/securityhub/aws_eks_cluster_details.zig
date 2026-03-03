const AwsEksClusterLoggingDetails = @import("aws_eks_cluster_logging_details.zig").AwsEksClusterLoggingDetails;
const AwsEksClusterResourcesVpcConfigDetails = @import("aws_eks_cluster_resources_vpc_config_details.zig").AwsEksClusterResourcesVpcConfigDetails;

/// Provides details about an Amazon EKS cluster.
pub const AwsEksClusterDetails = struct {
    /// The ARN of the cluster.
    arn: ?[]const u8 = null,

    /// The certificate authority data for the cluster.
    certificate_authority_data: ?[]const u8 = null,

    /// The status of the cluster. Valid values are as follows:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATING`
    ///
    /// * `DELETING`
    ///
    /// * `FAILED`
    ///
    /// * `PENDING`
    ///
    /// * `UPDATING`
    cluster_status: ?[]const u8 = null,

    /// The endpoint for the Amazon EKS API server.
    endpoint: ?[]const u8 = null,

    /// The logging configuration for the cluster.
    logging: ?AwsEksClusterLoggingDetails = null,

    /// The name of the cluster.
    name: ?[]const u8 = null,

    /// The VPC configuration used by the cluster control plane.
    resources_vpc_config: ?AwsEksClusterResourcesVpcConfigDetails = null,

    /// The ARN of the IAM role that provides permissions for the Amazon EKS control
    /// plane to make calls to Amazon Web Services API operations on your behalf.
    role_arn: ?[]const u8 = null,

    /// The Amazon EKS server version for the cluster.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .certificate_authority_data = "CertificateAuthorityData",
        .cluster_status = "ClusterStatus",
        .endpoint = "Endpoint",
        .logging = "Logging",
        .name = "Name",
        .resources_vpc_config = "ResourcesVpcConfig",
        .role_arn = "RoleArn",
        .version = "Version",
    };
};
