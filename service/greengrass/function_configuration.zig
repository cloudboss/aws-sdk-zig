const EncodingType = @import("encoding_type.zig").EncodingType;
const FunctionConfigurationEnvironment = @import("function_configuration_environment.zig").FunctionConfigurationEnvironment;

/// The configuration of the Lambda function.
pub const FunctionConfiguration = struct {
    /// The expected encoding type of the input payload for the function. The
    /// default is ''json''.
    encoding_type: ?EncodingType = null,

    /// The environment configuration of the function.
    environment: ?FunctionConfigurationEnvironment = null,

    /// The execution arguments.
    exec_args: ?[]const u8 = null,

    /// The name of the function executable.
    executable: ?[]const u8 = null,

    /// The Lambda runtime supported by Greengrass which is to be used instead of
    /// the one specified in the Lambda function.
    function_runtime_override: ?[]const u8 = null,

    /// The memory size, in KB, which the function requires. This setting is not
    /// applicable and should be cleared when you run the Lambda function without
    /// containerization.
    memory_size: ?i32 = null,

    /// True if the function is pinned. Pinned means the function is long-lived and
    /// starts when the core starts.
    pinned: ?bool = null,

    /// The allowed function execution time, after which Lambda should terminate the
    /// function. This timeout still applies to pinned Lambda functions for each
    /// request.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .encoding_type = "EncodingType",
        .environment = "Environment",
        .exec_args = "ExecArgs",
        .executable = "Executable",
        .function_runtime_override = "FunctionRuntimeOverride",
        .memory_size = "MemorySize",
        .pinned = "Pinned",
        .timeout = "Timeout",
    };
};
