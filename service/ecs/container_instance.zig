const AgentUpdateStatus = @import("agent_update_status.zig").AgentUpdateStatus;
const Attachment = @import("attachment.zig").Attachment;
const Attribute = @import("attribute.zig").Attribute;
const ContainerInstanceHealthStatus = @import("container_instance_health_status.zig").ContainerInstanceHealthStatus;
const Resource = @import("resource.zig").Resource;
const Tag = @import("tag.zig").Tag;
const VersionInfo = @import("version_info.zig").VersionInfo;

/// An Amazon EC2 or External instance that's running the Amazon ECS agent and
/// has been
/// registered with a cluster.
pub const ContainerInstance = struct {
    /// This parameter returns `true` if the agent is connected to Amazon ECS. An
    /// instance with an agent that may be unhealthy or stopped return `false`. Only
    /// instances connected to an agent can accept task placement requests.
    agent_connected: bool = false,

    /// The status of the most recent agent update. If an update wasn't ever
    /// requested, this
    /// value is `NULL`.
    agent_update_status: ?AgentUpdateStatus = null,

    /// The resources attached to a container instance, such as an elastic network
    /// interface.
    attachments: ?[]const Attachment = null,

    /// The attributes set for the container instance, either by the Amazon ECS
    /// container
    /// agent at instance registration or manually with the
    /// [PutAttributes](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAttributes.html)
    /// operation.
    attributes: ?[]const Attribute = null,

    /// The capacity provider that's associated with the container instance.
    capacity_provider_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the container instance. For more
    /// information about
    /// the ARN format, see [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html#ecs-resource-ids) in the *Amazon ECS Developer
    /// Guide*.
    container_instance_arn: ?[]const u8 = null,

    /// The ID of the container instance. For Amazon EC2 instances, this value is
    /// the Amazon
    /// EC2 instance ID. For external instances, this value is the Amazon Web
    /// Services Systems
    /// Manager managed instance ID.
    ec_2_instance_id: ?[]const u8 = null,

    /// An object representing the health status of the container instance.
    health_status: ?ContainerInstanceHealthStatus = null,

    /// The number of tasks on the container instance that are in the `PENDING`
    /// status.
    pending_tasks_count: i32 = 0,

    /// The Unix timestamp for the time when the container instance was registered.
    registered_at: ?i64 = null,

    /// For CPU and memory resource types, this parameter describes the amount of
    /// each
    /// resource that was available on the container instance when the container
    /// agent
    /// registered it with Amazon ECS. This value represents the total amount of CPU
    /// and memory
    /// that can be allocated on this container instance to tasks. For port resource
    /// types, this
    /// parameter describes the ports that were reserved by the Amazon ECS container
    /// agent when
    /// it registered the container instance with Amazon ECS.
    registered_resources: ?[]const Resource = null,

    /// For CPU and memory resource types, this parameter describes the remaining
    /// CPU and
    /// memory that wasn't already allocated to tasks and is therefore available for
    /// new tasks.
    /// For port resource types, this parameter describes the ports that were
    /// reserved by the
    /// Amazon ECS container agent (at instance registration time) and any task
    /// containers that
    /// have reserved port mappings on the host (with the `host` or
    /// `bridge` network mode). Any port that's not specified here is available
    /// for new tasks.
    remaining_resources: ?[]const Resource = null,

    /// The number of tasks on the container instance that have a desired status
    /// (`desiredStatus`) of `RUNNING`.
    running_tasks_count: i32 = 0,

    /// The status of the container instance. The valid values are `REGISTERING`,
    /// `REGISTRATION_FAILED`, `ACTIVE`, `INACTIVE`,
    /// `DEREGISTERING`, or `DRAINING`.
    ///
    /// If your account has opted in to the `awsvpcTrunking` account setting, then
    /// any newly registered container instance will transition to a `REGISTERING`
    /// status while the trunk elastic network interface is provisioned for the
    /// instance. If the
    /// registration fails, the instance will transition to a `REGISTRATION_FAILED`
    /// status. You can describe the container instance and see the reason for
    /// failure in the
    /// `statusReason` parameter. Once the container instance is terminated, the
    /// instance transitions to a `DEREGISTERING` status while the trunk elastic
    /// network interface is deprovisioned. The instance then transitions to an
    /// `INACTIVE` status.
    ///
    /// The `ACTIVE` status indicates that the container instance can accept tasks.
    /// The `DRAINING` indicates that new tasks aren't placed on the container
    /// instance and any service tasks running on the container instance are removed
    /// if
    /// possible. For more information, see [Container instance
    /// draining](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-draining.html) in the *Amazon
    /// Elastic Container Service Developer Guide*.
    status: ?[]const u8 = null,

    /// The reason that the container instance reached its current status.
    status_reason: ?[]const u8 = null,

    /// The metadata that you apply to the container instance to help you categorize
    /// and
    /// organize them. Each tag consists of a key and an optional value. You define
    /// both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only
    /// one value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8
    ///
    /// * If your tagging schema is used across multiple services and resources,
    /// remember that other services may have restrictions on allowed characters.
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in
    /// UTF-8, and the following characters: + - = . _ : / @.
    ///
    /// * Tag keys and values are case-sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase
    /// combination of such as a prefix for either keys or values as it is reserved
    /// for
    /// Amazon Web
    /// Services use. You cannot edit or delete tag keys or values with
    /// this prefix. Tags with this prefix do not count against your tags per
    /// resource
    /// limit.
    tags: ?[]const Tag = null,

    /// The version counter for the container instance. Every time a container
    /// instance
    /// experiences a change that triggers a CloudWatch event, the version counter
    /// is
    /// incremented. If you're replicating your Amazon ECS container instance state
    /// with
    /// CloudWatch Events, you can compare the version of a container instance
    /// reported by the
    /// Amazon ECS APIs with the version reported in CloudWatch Events for the
    /// container
    /// instance (inside the `detail` object) to verify that the version in your
    /// event stream is current.
    version: i64 = 0,

    /// The version information for the Amazon ECS container agent and Docker daemon
    /// running
    /// on the container instance.
    version_info: ?VersionInfo = null,

    pub const json_field_names = .{
        .agent_connected = "agentConnected",
        .agent_update_status = "agentUpdateStatus",
        .attachments = "attachments",
        .attributes = "attributes",
        .capacity_provider_name = "capacityProviderName",
        .container_instance_arn = "containerInstanceArn",
        .ec_2_instance_id = "ec2InstanceId",
        .health_status = "healthStatus",
        .pending_tasks_count = "pendingTasksCount",
        .registered_at = "registeredAt",
        .registered_resources = "registeredResources",
        .remaining_resources = "remainingResources",
        .running_tasks_count = "runningTasksCount",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .version = "version",
        .version_info = "versionInfo",
    };
};
