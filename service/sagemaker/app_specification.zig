/// Configuration to run a processing job in a specified container image.
pub const AppSpecification = struct {
    /// The arguments for a container used to run a processing job.
    container_arguments: ?[]const []const u8,

    /// The entrypoint for a container used to run a processing job.
    container_entrypoint: ?[]const []const u8,

    /// The container image to be run by the processing job.
    image_uri: []const u8,

    pub const json_field_names = .{
        .container_arguments = "ContainerArguments",
        .container_entrypoint = "ContainerEntrypoint",
        .image_uri = "ImageUri",
    };
};
