const EnvironmentError = @import("environment_error.zig").EnvironmentError;

/// The results of an operation to update or read environment variables. If the
/// operation succeeds, the response contains the environment variables. If it
/// fails, the response contains details about the error.
pub const EnvironmentResponse = struct {
    /// Error messages for environment variables that couldn't be applied.
    @"error": ?EnvironmentError,

    /// Environment variable key-value pairs. Omitted from CloudTrail logs.
    variables: ?[]const u8,
};
