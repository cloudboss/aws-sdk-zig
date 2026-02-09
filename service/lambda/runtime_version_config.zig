const RuntimeVersionError = @import("runtime_version_error.zig").RuntimeVersionError;

/// The ARN of the runtime and any errors that occured.
pub const RuntimeVersionConfig = struct {
    /// Error response when Lambda is unable to retrieve the runtime version for a
    /// function.
    @"error": ?RuntimeVersionError,

    /// The ARN of the runtime version you want the function to use.
    runtime_version_arn: ?[]const u8,
};
