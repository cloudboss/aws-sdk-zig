const Configuration = @import("configuration.zig").Configuration;

/// An Amazon Lex V2 chat bot created under an `AppInstance`.
pub const AppInstanceBot = struct {
    /// The ARN of the AppInstanceBot.
    app_instance_bot_arn: ?[]const u8 = null,

    /// The data processing instructions for an AppInstanceBot.
    configuration: ?Configuration = null,

    /// The time at which the `AppInstanceBot` was created.
    created_timestamp: ?i64 = null,

    /// The time at which the `AppInstanceBot` was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The metadata for an AppInstanceBot.
    metadata: ?[]const u8 = null,

    /// The name of the AppInstanceBot.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_bot_arn = "AppInstanceBotArn",
        .configuration = "Configuration",
        .created_timestamp = "CreatedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .metadata = "Metadata",
        .name = "Name",
    };
};
