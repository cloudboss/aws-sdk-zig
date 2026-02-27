const LinkApplicationLogConfiguration = @import("link_application_log_configuration.zig").LinkApplicationLogConfiguration;

/// Describes the settings for a link log.
pub const LinkLogSettings = struct {
    /// Describes the configuration of a link application log.
    application_logs: LinkApplicationLogConfiguration,

    pub const json_field_names = .{
        .application_logs = "applicationLogs",
    };
};
