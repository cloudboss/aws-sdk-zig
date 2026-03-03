const ContainerInstanceDetails = @import("container_instance_details.zig").ContainerInstanceDetails;
const FargateDetails = @import("fargate_details.zig").FargateDetails;

/// Contains information about Amazon ECS cluster runtime coverage details.
pub const CoverageEcsClusterDetails = struct {
    /// The name of the Amazon ECS cluster.
    cluster_name: ?[]const u8 = null,

    /// Information about the Amazon ECS container running on Amazon EC2
    /// instance.
    container_instance_details: ?ContainerInstanceDetails = null,

    /// Information about the Fargate details associated with the Amazon
    /// ECS cluster.
    fargate_details: ?FargateDetails = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .container_instance_details = "ContainerInstanceDetails",
        .fargate_details = "FargateDetails",
    };
};
