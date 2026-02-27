const AwsEcsMetadataDetails = @import("aws_ecs_metadata_details.zig").AwsEcsMetadataDetails;
const AwsEksMetadataDetails = @import("aws_eks_metadata_details.zig").AwsEksMetadataDetails;

/// The metadata for a cluster.
pub const ClusterMetadata = union(enum) {
    /// The details for an Amazon ECS cluster in the cluster metadata.
    aws_ecs_metadata_details: ?AwsEcsMetadataDetails,
    /// The details for an Amazon EKS cluster in the cluster metadata.
    aws_eks_metadata_details: ?AwsEksMetadataDetails,

    pub const json_field_names = .{
        .aws_ecs_metadata_details = "awsEcsMetadataDetails",
        .aws_eks_metadata_details = "awsEksMetadataDetails",
    };
};
