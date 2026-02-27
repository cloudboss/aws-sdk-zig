const AuthProvider = @import("auth_provider.zig").AuthProvider;
const AuthMode = @import("auth_mode.zig").AuthMode;
const EventLogConfig = @import("event_log_config.zig").EventLogConfig;

/// Describes the authorization configuration for connections, message
/// publishing, message
/// subscriptions, and logging for an Event API.
pub const EventConfig = struct {
    /// A list of authorization providers.
    auth_providers: []const AuthProvider,

    /// A list of valid authorization modes for the Event API connections.
    connection_auth_modes: []const AuthMode,

    /// A list of valid authorization modes for the Event API publishing.
    default_publish_auth_modes: []const AuthMode,

    /// A list of valid authorization modes for the Event API subscriptions.
    default_subscribe_auth_modes: []const AuthMode,

    /// The CloudWatch Logs configuration for the Event API.
    log_config: ?EventLogConfig,

    pub const json_field_names = .{
        .auth_providers = "authProviders",
        .connection_auth_modes = "connectionAuthModes",
        .default_publish_auth_modes = "defaultPublishAuthModes",
        .default_subscribe_auth_modes = "defaultSubscribeAuthModes",
        .log_config = "logConfig",
    };
};
