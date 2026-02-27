/// Contains the service and cluster names used to identify an Amazon ECS
/// deployment's target.
pub const ECSService = struct {
    /// The name of the cluster that the Amazon ECS service is associated with.
    cluster_name: ?[]const u8,

    /// The name of the target Amazon ECS service.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .service_name = "serviceName",
    };
};
