const ClusterEventResourceType = @import("cluster_event_resource_type.zig").ClusterEventResourceType;

/// A summary of an event in a HyperPod cluster.
pub const ClusterEventSummary = struct {
    /// The Amazon Resource Name (ARN) of the HyperPod cluster associated with the
    /// event.
    cluster_arn: []const u8,

    /// The name of the HyperPod cluster associated with the event.
    cluster_name: []const u8,

    /// A brief, human-readable description of the event.
    description: ?[]const u8,

    /// The unique identifier (UUID) of the event.
    event_id: []const u8,

    /// The timestamp when the event occurred.
    event_time: i64,

    /// The name of the instance group associated with the event, if applicable.
    instance_group_name: ?[]const u8,

    /// The Amazon Elastic Compute Cloud (EC2) instance ID associated with the
    /// event, if applicable.
    instance_id: ?[]const u8,

    /// The type of resource associated with the event. Valid values are `Cluster`,
    /// `InstanceGroup`, or `Instance`.
    resource_type: ClusterEventResourceType,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_name = "ClusterName",
        .description = "Description",
        .event_id = "EventId",
        .event_time = "EventTime",
        .instance_group_name = "InstanceGroupName",
        .instance_id = "InstanceId",
        .resource_type = "ResourceType",
    };
};
