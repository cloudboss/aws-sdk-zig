const HandlerConfig = @import("handler_config.zig").HandlerConfig;

/// The configuration for the `OnPublish` and `OnSubscribe` handlers.
pub const HandlerConfigs = struct {
    /// The configuration for the `OnPublish` handler.
    on_publish: ?HandlerConfig,

    /// The configuration for the `OnSubscribe` handler.
    on_subscribe: ?HandlerConfig,

    pub const json_field_names = .{
        .on_publish = "onPublish",
        .on_subscribe = "onSubscribe",
    };
};
