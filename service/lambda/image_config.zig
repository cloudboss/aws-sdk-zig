/// Configuration values that override the container image Dockerfile settings.
/// For more information, see [Container image
/// settings](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-parms).
pub const ImageConfig = struct {
    /// Specifies parameters that you want to pass in with ENTRYPOINT.
    command: ?[]const []const u8,

    /// Specifies the entry point to their application, which is typically the
    /// location of the runtime executable.
    entry_point: ?[]const []const u8,

    /// Specifies the working directory.
    working_directory: ?[]const u8,
};
