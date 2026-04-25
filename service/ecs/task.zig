const Attachment = @import("attachment.zig").Attachment;
const Attribute = @import("attribute.zig").Attribute;
const Connectivity = @import("connectivity.zig").Connectivity;
const Container = @import("container.zig").Container;
const EphemeralStorage = @import("ephemeral_storage.zig").EphemeralStorage;
const TaskEphemeralStorage = @import("task_ephemeral_storage.zig").TaskEphemeralStorage;
const HealthStatus = @import("health_status.zig").HealthStatus;
const InferenceAccelerator = @import("inference_accelerator.zig").InferenceAccelerator;
const LaunchType = @import("launch_type.zig").LaunchType;
const TaskOverride = @import("task_override.zig").TaskOverride;
const TaskStopCode = @import("task_stop_code.zig").TaskStopCode;
const Tag = @import("tag.zig").Tag;

/// Details on a task in a cluster.
pub const Task = struct {
    /// The Elastic Network Adapter that's associated with the task if the task uses
    /// the `awsvpc` network mode.
    attachments: ?[]const Attachment = null,

    /// The attributes of the task
    attributes: ?[]const Attribute = null,

    /// The Availability Zone for the task.
    availability_zone: ?[]const u8 = null,

    /// The capacity provider that's associated with the task.
    capacity_provider_name: ?[]const u8 = null,

    /// The ARN of the cluster that hosts the task.
    cluster_arn: ?[]const u8 = null,

    /// The connectivity status of a task.
    connectivity: ?Connectivity = null,

    /// The Unix timestamp for the time when the task last went into `CONNECTED`
    /// status.
    connectivity_at: ?i64 = null,

    /// The ARN of the container instances that host the task.
    container_instance_arn: ?[]const u8 = null,

    /// The containers that's associated with the task.
    containers: ?[]const Container = null,

    /// The number of CPU units used by the task as expressed in a task definition.
    /// It can be expressed as an integer using CPU units (for example, `1024`). It
    /// can also be expressed as a string using vCPUs (for example, `1 vCPU` or `1
    /// vcpu`). String values are converted to an integer that indicates the CPU
    /// units when the task definition is registered.
    ///
    /// If you're using the EC2 launch type or the external launch type, this field
    /// is optional. Supported values are between `128` CPU units (`0.125` vCPUs)
    /// and `196608` CPU units (`192` vCPUs). If you do not specify a value, the
    /// parameter is ignored.
    ///
    /// This field is required for Fargate. For information about the valid values,
    /// see [Task
    /// size](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) in the *Amazon Elastic Container Service Developer Guide*.
    cpu: ?[]const u8 = null,

    /// The Unix timestamp for the time when the task was created. More
    /// specifically, it's for the time when the task entered the `PENDING` state.
    created_at: ?i64 = null,

    /// The desired status of the task. For more information, see [Task
    /// Lifecycle](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-lifecycle.html).
    desired_status: ?[]const u8 = null,

    /// Determines whether execute command functionality is turned on for this task.
    /// If `true`, execute command functionality is turned on all the containers in
    /// the task.
    enable_execute_command: bool = false,

    /// The ephemeral storage settings for the task.
    ephemeral_storage: ?EphemeralStorage = null,

    /// The Unix timestamp for the time when the task execution stopped.
    execution_stopped_at: ?i64 = null,

    /// The Fargate ephemeral storage settings for the task.
    fargate_ephemeral_storage: ?TaskEphemeralStorage = null,

    /// The name of the task group that's associated with the task.
    group: ?[]const u8 = null,

    /// The health status for the task. It's determined by the health of the
    /// essential containers in the task. If all essential containers in the task
    /// are reporting as `HEALTHY`, the task status also reports as `HEALTHY`. If
    /// any essential containers in the task are reporting as `UNHEALTHY` or
    /// `UNKNOWN`, the task status also reports as `UNHEALTHY` or `UNKNOWN`.
    ///
    /// The Amazon ECS container agent doesn't monitor or report on Docker health
    /// checks that are embedded in a container image and not specified in the
    /// container definition. For example, this includes those specified in a parent
    /// image or from the image's Dockerfile. Health check parameters that are
    /// specified in a container definition override any Docker health checks that
    /// are found in the container image.
    health_status: ?HealthStatus = null,

    /// The Elastic Inference accelerator that's associated with the task.
    inference_accelerators: ?[]const InferenceAccelerator = null,

    /// The last known status for the task. For more information, see [Task
    /// Lifecycle](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-lifecycle.html).
    last_status: ?[]const u8 = null,

    /// The infrastructure where your task runs on. For more information, see
    /// [Amazon ECS launch
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_types.html) in the *Amazon Elastic Container Service Developer Guide*.
    launch_type: ?LaunchType = null,

    /// The amount of memory (in MiB) that the task uses as expressed in a task
    /// definition. It can be expressed as an integer using MiB (for example,
    /// `1024`). If it's expressed as a string using GB (for example, `1GB` or `1
    /// GB`), it's converted to an integer indicating the MiB when the task
    /// definition is registered.
    ///
    /// If you use the EC2 launch type, this field is optional.
    ///
    /// If you use the Fargate launch type, this field is required. You must use one
    /// of the following values. The value that you choose determines the range of
    /// supported values for the `cpu` parameter.
    ///
    /// * 512 (0.5 GB), 1024 (1 GB), 2048 (2 GB) - Available `cpu` values: 256 (.25
    ///   vCPU)
    /// * 1024 (1 GB), 2048 (2 GB), 3072 (3 GB), 4096 (4 GB) - Available `cpu`
    ///   values: 512 (.5 vCPU)
    /// * 2048 (2 GB), 3072 (3 GB), 4096 (4 GB), 5120 (5 GB), 6144 (6 GB), 7168 (7
    ///   GB), 8192 (8 GB) - Available `cpu` values: 1024 (1 vCPU)
    /// * Between 4096 (4 GB) and 16384 (16 GB) in increments of 1024 (1 GB) -
    ///   Available `cpu` values: 2048 (2 vCPU)
    /// * Between 8192 (8 GB) and 30720 (30 GB) in increments of 1024 (1 GB) -
    ///   Available `cpu` values: 4096 (4 vCPU)
    /// * Between 16 GB and 60 GB in 4 GB increments - Available `cpu` values: 8192
    ///   (8 vCPU)
    ///
    /// This option requires Linux platform `1.4.0` or later.
    /// * Between 32GB and 120 GB in 8 GB increments - Available `cpu` values: 16384
    ///   (16 vCPU)
    ///
    /// This option requires Linux platform `1.4.0` or later.
    memory: ?[]const u8 = null,

    /// One or more container overrides.
    overrides: ?TaskOverride = null,

    /// The operating system that your tasks are running on. A platform family is
    /// specified only for tasks that use the Fargate launch type.
    ///
    /// All tasks that run as part of this service must use the same
    /// `platformFamily` value as the service (for example, `LINUX.`).
    platform_family: ?[]const u8 = null,

    /// The platform version where your task runs on. A platform version is only
    /// specified for tasks that use the Fargate launch type. If you didn't specify
    /// one, the `LATEST` platform version is used. For more information, see
    /// [Fargate Platform
    /// Versions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html) in the *Amazon Elastic Container Service Developer Guide*.
    platform_version: ?[]const u8 = null,

    /// The Unix timestamp for the time when the container image pull began.
    pull_started_at: ?i64 = null,

    /// The Unix timestamp for the time when the container image pull completed.
    pull_stopped_at: ?i64 = null,

    /// The Unix timestamp for the time when the task started. More specifically,
    /// it's for the time when the task transitioned from the `PENDING` state to the
    /// `RUNNING` state.
    started_at: ?i64 = null,

    /// The tag specified when a task is started. If an Amazon ECS service started
    /// the task, the `startedBy` parameter contains the deployment ID of that
    /// service.
    started_by: ?[]const u8 = null,

    /// The stop code indicating why a task was stopped. The `stoppedReason` might
    /// contain additional details.
    ///
    /// For more information about stop code, see [Stopped tasks error
    /// codes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/stopped-task-error-codes.html) in the *Amazon ECS Developer Guide*.
    stop_code: ?TaskStopCode = null,

    /// The Unix timestamp for the time when the task was stopped. More
    /// specifically, it's for the time when the task transitioned from the
    /// `RUNNING` state to the `STOPPED` state.
    stopped_at: ?i64 = null,

    /// The reason that the task was stopped.
    stopped_reason: ?[]const u8 = null,

    /// The Unix timestamp for the time when the task stops. More specifically, it's
    /// for the time when the task transitions from the `RUNNING` state to
    /// `STOPPING`.
    stopping_at: ?i64 = null,

    /// The metadata that you apply to the task to help you categorize and organize
    /// the task. Each tag consists of a key and an optional value. You define both
    /// the key and value.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the task.
    task_arn: ?[]const u8 = null,

    /// The ARN of the task definition that creates the task.
    task_definition_arn: ?[]const u8 = null,

    /// The version counter for the task. Every time a task experiences a change
    /// that starts a CloudWatch event, the version counter is incremented. If you
    /// replicate your Amazon ECS task state with CloudWatch Events, you can compare
    /// the version of a task reported by the Amazon ECS API actions with the
    /// version reported in CloudWatch Events for the task (inside the `detail`
    /// object) to verify that the version in your event stream is current.
    version: i64 = 0,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attributes = "attributes",
        .availability_zone = "availabilityZone",
        .capacity_provider_name = "capacityProviderName",
        .cluster_arn = "clusterArn",
        .connectivity = "connectivity",
        .connectivity_at = "connectivityAt",
        .container_instance_arn = "containerInstanceArn",
        .containers = "containers",
        .cpu = "cpu",
        .created_at = "createdAt",
        .desired_status = "desiredStatus",
        .enable_execute_command = "enableExecuteCommand",
        .ephemeral_storage = "ephemeralStorage",
        .execution_stopped_at = "executionStoppedAt",
        .fargate_ephemeral_storage = "fargateEphemeralStorage",
        .group = "group",
        .health_status = "healthStatus",
        .inference_accelerators = "inferenceAccelerators",
        .last_status = "lastStatus",
        .launch_type = "launchType",
        .memory = "memory",
        .overrides = "overrides",
        .platform_family = "platformFamily",
        .platform_version = "platformVersion",
        .pull_started_at = "pullStartedAt",
        .pull_stopped_at = "pullStoppedAt",
        .started_at = "startedAt",
        .started_by = "startedBy",
        .stop_code = "stopCode",
        .stopped_at = "stoppedAt",
        .stopped_reason = "stoppedReason",
        .stopping_at = "stoppingAt",
        .tags = "tags",
        .task_arn = "taskArn",
        .task_definition_arn = "taskDefinitionArn",
        .version = "version",
    };
};
