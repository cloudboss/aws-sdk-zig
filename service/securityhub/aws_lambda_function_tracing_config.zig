/// The function's X-Ray tracing configuration.
pub const AwsLambdaFunctionTracingConfig = struct {
    /// The tracing mode.
    mode: ?[]const u8,

    pub const json_field_names = .{
        .mode = "Mode",
    };
};
