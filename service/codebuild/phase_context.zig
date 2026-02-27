/// Additional information about a build phase that has an error. You can use
/// this
/// information for troubleshooting.
pub const PhaseContext = struct {
    /// An explanation of the build phase's context. This might include a command ID
    /// and an
    /// exit code.
    message: ?[]const u8,

    /// The status code for the context of the build phase.
    status_code: ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
        .status_code = "statusCode",
    };
};
