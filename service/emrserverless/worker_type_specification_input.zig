const ImageConfigurationInput = @import("image_configuration_input.zig").ImageConfigurationInput;

/// The specifications for a worker type.
pub const WorkerTypeSpecificationInput = struct {
    /// The image configuration for a worker type.
    image_configuration: ?ImageConfigurationInput,

    pub const json_field_names = .{
        .image_configuration = "imageConfiguration",
    };
};
