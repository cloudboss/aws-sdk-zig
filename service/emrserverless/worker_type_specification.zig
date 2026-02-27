const ImageConfiguration = @import("image_configuration.zig").ImageConfiguration;

/// The specifications for a worker type.
pub const WorkerTypeSpecification = struct {
    /// The image configuration for a worker type.
    image_configuration: ?ImageConfiguration,

    pub const json_field_names = .{
        .image_configuration = "imageConfiguration",
    };
};
