/// High-level information about an AppInstanceBot.
pub const AppInstanceBotSummary = struct {
    /// The ARN of the AppInstanceBot.
    app_instance_bot_arn: ?[]const u8 = null,

    /// The metadata of the AppInstanceBot.
    metadata: ?[]const u8 = null,

    /// The name of the AppInstanceBox.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_bot_arn = "AppInstanceBotArn",
        .metadata = "Metadata",
        .name = "Name",
    };
};
