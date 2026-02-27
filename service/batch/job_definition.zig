const aws = @import("aws");

const ConsumableResourceProperties = @import("consumable_resource_properties.zig").ConsumableResourceProperties;
const OrchestrationType = @import("orchestration_type.zig").OrchestrationType;
const ContainerProperties = @import("container_properties.zig").ContainerProperties;
const EcsProperties = @import("ecs_properties.zig").EcsProperties;
const EksProperties = @import("eks_properties.zig").EksProperties;
const NodeProperties = @import("node_properties.zig").NodeProperties;
const PlatformCapability = @import("platform_capability.zig").PlatformCapability;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const JobTimeout = @import("job_timeout.zig").JobTimeout;

/// An object that represents an Batch job definition.
pub const JobDefinition = struct {
    /// Contains a list of consumable resources required by the job.
    consumable_resource_properties: ?ConsumableResourceProperties,

    /// The orchestration type of the compute environment. The valid values are
    /// `ECS`
    /// (default) or `EKS`.
    container_orchestration_type: ?OrchestrationType,

    /// An object with properties specific to Amazon ECS-based jobs. When
    /// `containerProperties` is used in the job definition, it can't be used in
    /// addition to
    /// `eksProperties`, `ecsProperties`, or `nodeProperties`.
    container_properties: ?ContainerProperties,

    /// An object that contains the properties for the Amazon ECS resources of a
    /// job.When
    /// `ecsProperties` is used in the job definition, it can't be used in addition
    /// to
    /// `containerProperties`, `eksProperties`, or
    /// `nodeProperties`.
    ecs_properties: ?EcsProperties,

    /// An object with properties that are specific to Amazon EKS-based jobs. When
    /// `eksProperties` is used in the job definition, it can't be used in addition
    /// to
    /// `containerProperties`, `ecsProperties`, or
    /// `nodeProperties`.
    eks_properties: ?EksProperties,

    /// The Amazon Resource Name (ARN) for the job definition.
    job_definition_arn: []const u8,

    /// The name of the job definition.
    job_definition_name: []const u8,

    /// An object with properties that are specific to multi-node parallel jobs.
    /// When
    /// `nodeProperties` is used in the job definition, it can't be used in addition
    /// to
    /// `containerProperties`, `ecsProperties`, or
    /// `eksProperties`.
    ///
    /// If the job runs on Fargate resources, don't specify `nodeProperties`. Use
    /// `containerProperties` instead.
    node_properties: ?NodeProperties,

    /// Default parameters or parameter substitution placeholders that are set in
    /// the job
    /// definition. Parameters are specified as a key-value pair mapping. Parameters
    /// in a
    /// `SubmitJob` request override any corresponding parameter defaults from the
    /// job
    /// definition. For more information about specifying parameters, see [Job
    /// definition
    /// parameters](https://docs.aws.amazon.com/batch/latest/userguide/job_definition_parameters.html) in the
    /// *Batch User Guide*.
    parameters: ?[]const aws.map.StringMapEntry,

    /// The platform capabilities required by the job definition. If no value is
    /// specified, it
    /// defaults to `EC2`. Jobs run on Fargate resources specify
    /// `FARGATE`.
    platform_capabilities: ?[]const PlatformCapability,

    /// Specifies whether to propagate the tags from the job or job definition to
    /// the corresponding
    /// Amazon ECS task. If no value is specified, the tags aren't propagated. Tags
    /// can only be propagated to
    /// the tasks when the tasks are created. For tags with the same name, job tags
    /// are given priority
    /// over job definitions tags. If the total number of combined tags from the job
    /// and job definition
    /// is over 50, the job is moved to the `FAILED` state.
    propagate_tags: ?bool,

    /// The retry strategy to use for failed jobs that are submitted with this job
    /// definition.
    retry_strategy: ?RetryStrategy,

    /// The revision of the job definition.
    revision: i32,

    /// The scheduling priority of the job definition. This only affects jobs in job
    /// queues with a
    /// fair-share policy. Jobs with a higher scheduling priority are scheduled
    /// before jobs with a lower
    /// scheduling priority.
    scheduling_priority: ?i32,

    /// The status of the job definition.
    status: ?[]const u8,

    /// The tags that are applied to the job definition.
    tags: ?[]const aws.map.StringMapEntry,

    /// The timeout time for jobs that are submitted with this job definition. After
    /// the amount of
    /// time you specify passes, Batch terminates your jobs if they aren't finished.
    timeout: ?JobTimeout,

    /// The type of job definition. It's either `container` or `multinode`. If
    /// the job is run on Fargate resources, then `multinode` isn't supported. For
    /// more
    /// information about multi-node parallel jobs, see [Creating a multi-node
    /// parallel job
    /// definition](https://docs.aws.amazon.com/batch/latest/userguide/multi-node-job-def.html) in
    /// the *Batch User Guide*.
    @"type": []const u8,

    pub const json_field_names = .{
        .consumable_resource_properties = "consumableResourceProperties",
        .container_orchestration_type = "containerOrchestrationType",
        .container_properties = "containerProperties",
        .ecs_properties = "ecsProperties",
        .eks_properties = "eksProperties",
        .job_definition_arn = "jobDefinitionArn",
        .job_definition_name = "jobDefinitionName",
        .node_properties = "nodeProperties",
        .parameters = "parameters",
        .platform_capabilities = "platformCapabilities",
        .propagate_tags = "propagateTags",
        .retry_strategy = "retryStrategy",
        .revision = "revision",
        .scheduling_priority = "schedulingPriority",
        .status = "status",
        .tags = "tags",
        .timeout = "timeout",
        .@"type" = "type",
    };
};
