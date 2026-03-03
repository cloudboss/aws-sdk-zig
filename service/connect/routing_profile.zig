const aws = @import("aws");

const AgentAvailabilityTimer = @import("agent_availability_timer.zig").AgentAvailabilityTimer;
const MediaConcurrency = @import("media_concurrency.zig").MediaConcurrency;

/// Contains information about a routing profile.
pub const RoutingProfile = struct {
    /// Whether agents with this routing profile will have their routing order
    /// calculated based on *time since
    /// their last inbound contact* or *longest idle time*.
    agent_availability_timer: ?AgentAvailabilityTimer = null,

    /// The IDs of the associated manual assignment queues.
    associated_manual_assignment_queue_ids: ?[]const []const u8 = null,

    /// The IDs of the associated queue.
    associated_queue_ids: ?[]const []const u8 = null,

    /// The identifier of the default outbound queue for this routing profile.
    default_outbound_queue_id: ?[]const u8 = null,

    /// The description of the routing profile.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: ?[]const u8 = null,

    /// Whether this a default routing profile.
    is_default: bool = false,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The channels agents can handle in the Contact Control Panel (CCP) for this
    /// routing profile.
    media_concurrencies: ?[]const MediaConcurrency = null,

    /// The name of the routing profile.
    name: ?[]const u8 = null,

    /// The number of associated manual assignment queues in routing profile.
    number_of_associated_manual_assignment_queues: ?i64 = null,

    /// The number of associated queues in routing profile.
    number_of_associated_queues: ?i64 = null,

    /// The number of associated users in routing profile.
    number_of_associated_users: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the routing profile.
    routing_profile_arn: ?[]const u8 = null,

    /// The identifier of the routing profile.
    routing_profile_id: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_availability_timer = "AgentAvailabilityTimer",
        .associated_manual_assignment_queue_ids = "AssociatedManualAssignmentQueueIds",
        .associated_queue_ids = "AssociatedQueueIds",
        .default_outbound_queue_id = "DefaultOutboundQueueId",
        .description = "Description",
        .instance_id = "InstanceId",
        .is_default = "IsDefault",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .media_concurrencies = "MediaConcurrencies",
        .name = "Name",
        .number_of_associated_manual_assignment_queues = "NumberOfAssociatedManualAssignmentQueues",
        .number_of_associated_queues = "NumberOfAssociatedQueues",
        .number_of_associated_users = "NumberOfAssociatedUsers",
        .routing_profile_arn = "RoutingProfileArn",
        .routing_profile_id = "RoutingProfileId",
        .tags = "Tags",
    };
};
