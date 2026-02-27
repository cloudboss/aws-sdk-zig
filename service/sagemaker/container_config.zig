const aws = @import("aws");

/// The configuration used to run the application image container.
pub const ContainerConfig = struct {
    /// The arguments for the container when you're running the application.
    container_arguments: ?[]const []const u8,

    /// The entrypoint used to run the application in the container.
    container_entrypoint: ?[]const []const u8,

    /// The environment variables to set in the container
    container_environment_variables: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .container_arguments = "ContainerArguments",
        .container_entrypoint = "ContainerEntrypoint",
        .container_environment_variables = "ContainerEnvironmentVariables",
    };
};
