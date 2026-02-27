const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;

/// The overrides that should be sent to a container.
///
/// For information about using Batch overrides when you connect event sources
/// to targets, see
/// [BatchContainerOverrides](https://docs.aws.amazon.com/eventbridge/latest/pipes-reference/API_BatchContainerOverrides.html).
pub const ContainerOverrides = struct {
    /// The command to send to the container that overrides the default command from
    /// the Docker
    /// image or the job definition.
    ///
    /// This parameter can't contain an empty string.
    command: ?[]const []const u8,

    /// The environment variables to send to the container. You can add new
    /// environment variables,
    /// which are added to the container at launch, or you can override the existing
    /// environment
    /// variables from the Docker image or the job definition.
    ///
    /// Environment variables cannot start with "`AWS_BATCH`". This naming
    /// convention is reserved for variables that Batch sets.
    environment: ?[]const KeyValuePair,

    /// The instance type to use for a multi-node parallel job.
    ///
    /// This parameter isn't applicable to single-node container jobs or jobs that
    /// run on Fargate
    /// resources, and shouldn't be provided.
    instance_type: ?[]const u8,

    /// This parameter is deprecated, use `resourceRequirements` to override the
    /// memory
    /// requirements specified in the job definition. It's not supported for jobs
    /// running on Fargate
    /// resources. For jobs that run on Amazon EC2 resources, it overrides the
    /// `memory` parameter
    /// set in the job definition, but doesn't override any memory requirement
    /// that's specified in the
    /// `resourceRequirements` structure in the job definition. To override memory
    /// requirements that are specified in the `resourceRequirements` structure in
    /// the job
    /// definition, `resourceRequirements` must be specified in the `SubmitJob`
    /// request, with `type` set to `MEMORY` and `value` set to the new
    /// value. For more information, see [Can't override job
    /// definition resource
    /// requirements](https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#override-resource-requirements) in the *Batch User Guide*.
    memory: ?i32,

    /// The type and amount of resources to assign to a container. This overrides
    /// the settings in
    /// the job definition. The supported resources include `GPU`, `MEMORY`, and
    /// `VCPU`.
    resource_requirements: ?[]const ResourceRequirement,

    /// This parameter is deprecated, use `resourceRequirements` to override the
    /// `vcpus` parameter that's set in the job definition. It's not supported for
    /// jobs
    /// running on Fargate resources. For jobs that run on Amazon EC2 resources, it
    /// overrides the
    /// `vcpus` parameter set in the job definition, but doesn't override any vCPU
    /// requirement specified in the `resourceRequirements` structure in the job
    /// definition.
    /// To override vCPU requirements that are specified in the
    /// `resourceRequirements`
    /// structure in the job definition, `resourceRequirements` must be specified in
    /// the
    /// `SubmitJob` request, with `type` set to `VCPU` and
    /// `value` set to the new value. For more information, see [Can't override job
    /// definition resource
    /// requirements](https://docs.aws.amazon.com/batch/latest/userguide/troubleshooting.html#override-resource-requirements) in the *Batch User Guide*.
    vcpus: ?i32,

    pub const json_field_names = .{
        .command = "command",
        .environment = "environment",
        .instance_type = "instanceType",
        .memory = "memory",
        .resource_requirements = "resourceRequirements",
        .vcpus = "vcpus",
    };
};
