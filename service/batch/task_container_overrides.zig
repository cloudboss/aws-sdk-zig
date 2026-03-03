const KeyValuePair = @import("key_value_pair.zig").KeyValuePair;
const ResourceRequirement = @import("resource_requirement.zig").ResourceRequirement;

/// The overrides that should be sent to a container.
///
/// For information about using Batch overrides when you connect event sources
/// to targets, see
/// [BatchContainerOverrides](https://docs.aws.amazon.com/eventbridge/latest/pipes-reference/API_BatchContainerOverrides.html).
pub const TaskContainerOverrides = struct {
    /// The command to send to the container that overrides the default command from
    /// the Docker
    /// image or the job definition.
    ///
    /// This parameter can't contain an empty string.
    command: ?[]const []const u8 = null,

    /// The environment variables to send to the container. You can add new
    /// environment variables,
    /// which are added to the container at launch, or you can override the existing
    /// environment
    /// variables from the Docker image or the job definition.
    ///
    /// Environment variables cannot start with `AWS_BATCH`. This naming convention
    /// is
    /// reserved for variables that Batch sets.
    environment: ?[]const KeyValuePair = null,

    /// A pointer to the container that you want to override. The container's name
    /// provides a unique
    /// identifier for the container being used.
    name: ?[]const u8 = null,

    /// The type and amount of resources to assign to a container. This overrides
    /// the settings in
    /// the job definition. The supported resources include `GPU`, `MEMORY`, and
    /// `VCPU`.
    resource_requirements: ?[]const ResourceRequirement = null,

    pub const json_field_names = .{
        .command = "command",
        .environment = "environment",
        .name = "name",
        .resource_requirements = "resourceRequirements",
    };
};
