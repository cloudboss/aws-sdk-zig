const LaunchTemplateErrorCode = @import("launch_template_error_code.zig").LaunchTemplateErrorCode;

/// Describes the error that's returned when you cannot delete a launch template
/// version.
pub const ResponseError = struct {
    /// The error code.
    code: ?LaunchTemplateErrorCode = null,

    /// The error message, if applicable.
    message: ?[]const u8 = null,
};
