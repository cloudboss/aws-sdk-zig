const ExternalUrlConfig = @import("external_url_config.zig").ExternalUrlConfig;

/// The configuration for where the application should be loaded from.
pub const ApplicationSourceConfig = struct {
    /// The external URL source for the application.
    external_url_config: ?ExternalUrlConfig,

    pub const json_field_names = .{
        .external_url_config = "ExternalUrlConfig",
    };
};
