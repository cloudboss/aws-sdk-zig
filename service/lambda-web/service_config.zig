const aws = @import("aws");

const TelemetryConfig = @import("telemetry_config.zig").TelemetryConfig;

/// The service configuration for a web function revision, including execution
/// role, timeout, concurrency, and telemetry settings.
pub const ServiceConfig = struct {
    /// A map of environment variable key-value pairs available to the web function
    /// at runtime. Environment variable values are sensitive.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the IAM role that the web function assumes when it runs. This
    /// role provides permissions to access AWS services and resources.
    execution_role_arn: []const u8,

    /// The maximum number of concurrent requests handled per execution environment.
    /// Minimum value of 1, maximum value of 128. If you don't specify a value, the
    /// default is 64, and this default is returned in the response.
    max_concurrency_per_environment: i32 = 64,

    /// The telemetry configuration for the web function, including logging
    /// settings.
    telemetry_config: ?TelemetryConfig = null,

    /// The amount of time (in seconds) that Lambda allows the web function to run
    /// before stopping it. Minimum value of 3, maximum value of 900. If you don't
    /// specify a value, the default is 30, and this default is returned in the
    /// response.
    timeout_seconds: i32 = 30,

    pub const json_field_names = .{
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .max_concurrency_per_environment = "maxConcurrencyPerEnvironment",
        .telemetry_config = "telemetryConfig",
        .timeout_seconds = "timeoutSeconds",
    };
};
