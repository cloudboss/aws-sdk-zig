const CoverageEc2InstanceDetails = @import("coverage_ec_2_instance_details.zig").CoverageEc2InstanceDetails;
const CoverageEcsClusterDetails = @import("coverage_ecs_cluster_details.zig").CoverageEcsClusterDetails;
const CoverageEksClusterDetails = @import("coverage_eks_cluster_details.zig").CoverageEksClusterDetails;
const ResourceType = @import("resource_type.zig").ResourceType;

/// Information about the resource for each individual EKS cluster.
pub const CoverageResourceDetails = struct {
    /// Information about the Amazon EC2 instance assessed
    /// for runtime coverage.
    ec_2_instance_details: ?CoverageEc2InstanceDetails,

    /// Information about the Amazon ECS cluster that is assessed for
    /// runtime coverage.
    ecs_cluster_details: ?CoverageEcsClusterDetails,

    /// EKS cluster details involved in the coverage statistics.
    eks_cluster_details: ?CoverageEksClusterDetails,

    /// The type of Amazon Web Services resource.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .ec_2_instance_details = "Ec2InstanceDetails",
        .ecs_cluster_details = "EcsClusterDetails",
        .eks_cluster_details = "EksClusterDetails",
        .resource_type = "ResourceType",
    };
};
