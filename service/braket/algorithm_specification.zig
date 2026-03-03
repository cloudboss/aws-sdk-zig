const ContainerImage = @import("container_image.zig").ContainerImage;
const ScriptModeConfig = @import("script_mode_config.zig").ScriptModeConfig;

/// Defines the Amazon Braket hybrid job to be created. Specifies the container
/// image the job uses and the paths to the Python scripts used for entry and
/// training.
pub const AlgorithmSpecification = struct {
    /// The container image used to create an Amazon Braket hybrid job.
    container_image: ?ContainerImage = null,

    /// Configures the paths to the Python scripts used for entry and training.
    script_mode_config: ?ScriptModeConfig = null,

    pub const json_field_names = .{
        .container_image = "containerImage",
        .script_mode_config = "scriptModeConfig",
    };
};
