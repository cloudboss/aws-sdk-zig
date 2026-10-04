const CapacityProviderLoggingConfig = @import("capacity_provider_logging_config.zig").CapacityProviderLoggingConfig;

/// Configuration that specifies the telemetry collection for the capacity
/// provider.
pub const CapacityProviderTelemetryConfig = struct {
    /// The capacity provider's Amazon CloudWatch Logs configuration settings.
    logging_config: ?CapacityProviderLoggingConfig = null,

    pub const json_field_names = .{
        .logging_config = "LoggingConfig",
    };
};
