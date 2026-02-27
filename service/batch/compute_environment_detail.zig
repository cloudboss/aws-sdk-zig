const aws = @import("aws");

const ComputeResource = @import("compute_resource.zig").ComputeResource;
const OrchestrationType = @import("orchestration_type.zig").OrchestrationType;
const EksConfiguration = @import("eks_configuration.zig").EksConfiguration;
const CEState = @import("ce_state.zig").CEState;
const CEStatus = @import("ce_status.zig").CEStatus;
const CEType = @import("ce_type.zig").CEType;
const UpdatePolicy = @import("update_policy.zig").UpdatePolicy;

/// An object that represents an Batch compute environment.
pub const ComputeEnvironmentDetail = struct {
    /// The Amazon Resource Name (ARN) of the compute environment.
    compute_environment_arn: []const u8,

    /// The name of the compute environment. It can be up to 128 characters long. It
    /// can contain uppercase and
    /// lowercase letters, numbers, hyphens (-), and underscores (_).
    compute_environment_name: []const u8,

    /// The compute resources defined for the compute environment. For more
    /// information, see [Compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in
    /// the *Batch User Guide*.
    compute_resources: ?ComputeResource,

    /// The orchestration type of the compute environment. The valid values are
    /// `ECS`
    /// (default) or `EKS`.
    container_orchestration_type: ?OrchestrationType,

    /// Reserved.
    context: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the underlying Amazon ECS cluster that the
    /// compute environment uses.
    ecs_cluster_arn: ?[]const u8,

    /// The configuration for the Amazon EKS cluster that supports the Batch compute
    /// environment. Only
    /// specify this parameter if the `containerOrchestrationType` is `EKS`.
    eks_configuration: ?EksConfiguration,

    /// The service role that's associated with the compute environment that allows
    /// Batch to make
    /// calls to Amazon Web Services API operations on your behalf. For more
    /// information, see [Batch service IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html) in the
    /// *Batch User Guide*.
    service_role: ?[]const u8,

    /// The state of the compute environment. The valid values are `ENABLED` or
    /// `DISABLED`.
    ///
    /// If the state is `ENABLED`, then the Batch scheduler can attempt to place
    /// jobs
    /// from an associated job queue on the compute resources within the
    /// environment. If the compute
    /// environment is managed, then it can scale its instances out or in
    /// automatically based on the job
    /// queue demand.
    ///
    /// If the state is `DISABLED`, then the Batch scheduler doesn't attempt to
    /// place
    /// jobs within the environment. Jobs in a `STARTING` or `RUNNING` state
    /// continue to progress normally. Managed compute environments in the
    /// `DISABLED` state
    /// don't scale out.
    ///
    /// Compute environments in a `DISABLED` state may continue to incur billing
    /// charges. To prevent additional charges, turn off and then delete the compute
    /// environment. For
    /// more information, see
    /// [State](https://docs.aws.amazon.com/batch/latest/userguide/compute_environment_parameters.html#compute_environment_state) in the *Batch User Guide*.
    ///
    /// When an instance is idle, the instance scales down to the `minvCpus` value.
    /// However, the instance size doesn't change. For example, consider a
    /// `c5.8xlarge`
    /// instance with a `minvCpus` value of `4` and a `desiredvCpus`
    /// value of `36`. This instance doesn't scale down to a `c5.large`
    /// instance.
    state: ?CEState,

    /// The current status of the compute environment (for example, `CREATING` or
    /// `VALID`).
    status: ?CEStatus,

    /// A short, human-readable string to provide additional details for the current
    /// status of the
    /// compute environment.
    status_reason: ?[]const u8,

    /// The tags applied to the compute environment.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of the compute environment: `MANAGED` or `UNMANAGED`. For
    /// more information, see [Compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the *Batch User Guide*.
    @"type": ?CEType,

    /// The maximum number of VCPUs expected to be used for an unmanaged compute
    /// environment.
    unmanagedv_cpus: ?i32,

    /// Specifies the infrastructure update policy for the compute environment. For
    /// more information
    /// about infrastructure updates, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
    /// *Batch User Guide*.
    update_policy: ?UpdatePolicy,

    /// Unique identifier for the compute environment.
    uuid: ?[]const u8,

    pub const json_field_names = .{
        .compute_environment_arn = "computeEnvironmentArn",
        .compute_environment_name = "computeEnvironmentName",
        .compute_resources = "computeResources",
        .container_orchestration_type = "containerOrchestrationType",
        .context = "context",
        .ecs_cluster_arn = "ecsClusterArn",
        .eks_configuration = "eksConfiguration",
        .service_role = "serviceRole",
        .state = "state",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .@"type" = "type",
        .unmanagedv_cpus = "unmanagedvCpus",
        .update_policy = "updatePolicy",
        .uuid = "uuid",
    };
};
