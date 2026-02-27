const MemoryType = @import("memory_type.zig").MemoryType;
const SessionSummaryConfiguration = @import("session_summary_configuration.zig").SessionSummaryConfiguration;

/// Details of the memory configuration.
pub const MemoryConfiguration = struct {
    /// The type of memory that is stored.
    enabled_memory_types: []const MemoryType,

    /// Contains the configuration for SESSION_SUMMARY memory type enabled for the
    /// agent.
    session_summary_configuration: ?SessionSummaryConfiguration,

    /// The number of days the agent is configured to retain the conversational
    /// context.
    storage_days: i32 = 30,

    pub const json_field_names = .{
        .enabled_memory_types = "enabledMemoryTypes",
        .session_summary_configuration = "sessionSummaryConfiguration",
        .storage_days = "storageDays",
    };
};
