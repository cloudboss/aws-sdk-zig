const LoggingDestination = @import("logging_destination.zig").LoggingDestination;
const QueryLoggingConfigurationStatus = @import("query_logging_configuration_status.zig").QueryLoggingConfigurationStatus;

/// The metadata for a query logging configuration.
pub const QueryLoggingConfigurationMetadata = struct {
    /// The date and time when the query logging configuration was created.
    created_at: i64,

    /// The configured destinations for the query logging configuration.
    destinations: []const LoggingDestination,

    /// The date and time when the query logging configuration was last modified.
    modified_at: i64,

    /// The current status of the query logging configuration.
    status: QueryLoggingConfigurationStatus,

    /// The ID of the workspace associated with this query logging configuration.
    workspace: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .destinations = "destinations",
        .modified_at = "modifiedAt",
        .status = "status",
        .workspace = "workspace",
    };
};
