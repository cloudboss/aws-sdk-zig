const EventSourceMappingSystemLogLevel = @import("event_source_mapping_system_log_level.zig").EventSourceMappingSystemLogLevel;

/// (Amazon MSK, and self-managed Apache Kafka only) The logging configuration
/// for your event source. Use this configuration object to define the level of
/// logs for your event source mapping.
pub const EventSourceMappingLoggingConfig = struct {
    /// The log level you want your event source mapping to use. Lambda event poller
    /// only sends system logs at the selected level of detail and lower, where
    /// `DEBUG` is the highest level and `WARN` is the lowest. For more information
    /// about these metrics, see [ Event source mapping
    /// logging](https://docs.aws.amazon.com/lambda/latest/dg/esm-logging.html).
    system_log_level: ?EventSourceMappingSystemLogLevel,

    pub const json_field_names = .{
        .system_log_level = "SystemLogLevel",
    };
};
