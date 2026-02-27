/// The environment variables to send to the container. You can add new
/// environment
/// variables, which are added to the container at launch, or you can override
/// the existing
/// environment variables from the Docker image or the task definition.
///
/// Environment variables cannot start with "`Batch`". This
/// naming convention is reserved for variables that Batch sets.
pub const BatchEnvironmentVariable = struct {
    /// The name of the key-value pair. For environment variables, this is the name
    /// of the
    /// environment variable.
    name: ?[]const u8,

    /// The value of the key-value pair. For environment variables, this is the
    /// value of the
    /// environment variable.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
