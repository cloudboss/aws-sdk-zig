const LogLevel = @import("log_level.zig").LogLevel;

/// List of event log configurations.
pub const EventLogConfigurationSummary = struct {
    /// The logging level for the event log configuration.
    event_log_level: ?LogLevel = null,

    /// The identifier of the event log configuration.
    id: ?[]const u8 = null,

    /// The identifier of the resource for the event log configuration.
    resource_id: ?[]const u8 = null,

    /// The type of resource for the event log configuration.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_log_level = "EventLogLevel",
        .id = "Id",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
    };
};
