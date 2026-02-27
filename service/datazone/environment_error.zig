/// The failure reasons for the environment deployment.
pub const EnvironmentError = struct {
    /// The error code for the failure reason for the environment deployment.
    code: ?[]const u8,

    /// The error message for the failure reason for the environment deployment.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
