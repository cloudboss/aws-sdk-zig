const aws = @import("aws");

const EventFilter = @import("event_filter.zig").EventFilter;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;

/// The session logger resource.
pub const SessionLogger = struct {
    /// The additional encryption context of the session logger.
    additional_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The associated portal ARN.
    associated_portal_arns: ?[]const []const u8,

    /// The date the session logger resource was created.
    creation_date: ?i64,

    /// The custom managed key of the session logger.
    customer_managed_key: ?[]const u8,

    /// The human-readable display name.
    display_name: ?[]const u8,

    /// The filter that specifies which events to monitor.
    event_filter: ?EventFilter,

    /// The configuration that specifies where logs are fowarded.
    log_configuration: ?LogConfiguration,

    /// The ARN of the session logger resource.
    session_logger_arn: []const u8,

    pub const json_field_names = .{
        .additional_encryption_context = "additionalEncryptionContext",
        .associated_portal_arns = "associatedPortalArns",
        .creation_date = "creationDate",
        .customer_managed_key = "customerManagedKey",
        .display_name = "displayName",
        .event_filter = "eventFilter",
        .log_configuration = "logConfiguration",
        .session_logger_arn = "sessionLoggerArn",
    };
};
