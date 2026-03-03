const aws = @import("aws");

const HandlerConfigs = @import("handler_configs.zig").HandlerConfigs;
const AuthMode = @import("auth_mode.zig").AuthMode;

/// Describes a channel namespace associated with an `Api`. The
/// `ChannelNamespace` contains the definitions for code handlers for the
/// `Api`.
pub const ChannelNamespace = struct {
    /// The `Api` ID.
    api_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the `ChannelNamespace`.
    channel_namespace_arn: ?[]const u8 = null,

    /// The event handler functions that run custom business logic to process
    /// published events
    /// and subscribe requests.
    code_handlers: ?[]const u8 = null,

    /// The date and time that the `ChannelNamespace` was created.
    created: ?i64 = null,

    /// The configuration for the `OnPublish` and `OnSubscribe` handlers.
    handler_configs: ?HandlerConfigs = null,

    /// The date and time that the `ChannelNamespace` was last changed.
    last_modified: ?i64 = null,

    /// The name of the channel namespace. This name must be unique within the
    /// `Api`.
    name: ?[]const u8 = null,

    /// The authorization mode to use for publishing messages on the channel
    /// namespace. This
    /// configuration overrides the default `Api`authorization configuration.
    publish_auth_modes: ?[]const AuthMode = null,

    /// The authorization mode to use for subscribing to messages on the channel
    /// namespace. This
    /// configuration overrides the default `Api`authorization configuration.
    subscribe_auth_modes: ?[]const AuthMode = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .api_id = "apiId",
        .channel_namespace_arn = "channelNamespaceArn",
        .code_handlers = "codeHandlers",
        .created = "created",
        .handler_configs = "handlerConfigs",
        .last_modified = "lastModified",
        .name = "name",
        .publish_auth_modes = "publishAuthModes",
        .subscribe_auth_modes = "subscribeAuthModes",
        .tags = "tags",
    };
};
