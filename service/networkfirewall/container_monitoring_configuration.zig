const ContainerAttribute = @import("container_attribute.zig").ContainerAttribute;

/// Contains the monitoring configuration for a single cluster in a container
/// association. Specifies the cluster
/// ARN and optional attribute filters to narrow which containers are tracked.
pub const ContainerMonitoringConfiguration = struct {
    /// Key-value pairs that filter which containers are tracked. For Amazon EKS,
    /// you can filter by namespace and
    /// Kubernetes labels. For Amazon ECS, you can filter by container instance
    /// attributes (EC2 launch type only).
    attribute_filters: ?[]const ContainerAttribute = null,

    /// The ARN of the Amazon ECS or Amazon EKS cluster to monitor. The cluster must
    /// be in the same Region and account as
    /// the container association.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .attribute_filters = "AttributeFilters",
        .cluster_arn = "ClusterArn",
    };
};
