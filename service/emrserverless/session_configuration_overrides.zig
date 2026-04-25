const Configuration = @import("configuration.zig").Configuration;

/// The configuration overrides for a session.
pub const SessionConfigurationOverrides = struct {
    /// The runtime configuration for the session. Contains Spark configuration
    /// properties specified at session creation time.
    runtime_configuration: ?[]const Configuration = null,

    pub const json_field_names = .{
        .runtime_configuration = "runtimeConfiguration",
    };
};
