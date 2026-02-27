const S3Location = @import("s3_location.zig").S3Location;

/// Describes the details of the script.
pub const ScriptDetails = struct {
    /// The runtime parameters passed to the run path for the script.
    executable_parameters: ?[]const u8,

    /// The run path for the script.
    executable_path: []const u8,

    /// The S3 object location for the script.
    script_s3_location: S3Location,

    /// The run timeout, in seconds, for the script.
    timeout_in_seconds: i32,

    pub const json_field_names = .{
        .executable_parameters = "ExecutableParameters",
        .executable_path = "ExecutablePath",
        .script_s3_location = "ScriptS3Location",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};
