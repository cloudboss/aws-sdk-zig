const aws = @import("aws");

const DataPrivacy = @import("data_privacy.zig").DataPrivacy;
const ErrorLogSettings = @import("error_log_settings.zig").ErrorLogSettings;

/// Provides the bot parameters required for importing a bot.
pub const BotImportSpecification = struct {
    /// The name that Amazon Lex should use for the bot.
    bot_name: []const u8,

    /// A list of tags to add to the bot. You can only add tags when you
    /// import a bot. You can't use the `UpdateBot` operation to
    /// update tags. To update tags, use the `TagResource`
    /// operation.
    bot_tags: ?[]const aws.map.StringMapEntry = null,

    data_privacy: DataPrivacy,

    /// Allows you to configure destinations where error logs will be published
    /// during the bot import process.
    error_log_settings: ?ErrorLogSettings = null,

    /// The time, in seconds, that Amazon Lex should keep information about a
    /// user's conversation with the bot.
    ///
    /// A user interaction remains active for the amount of time specified.
    /// If no conversation occurs during this time, the session expires and
    /// Amazon Lex deletes any data provided before the timeout.
    ///
    /// You can specify between 60 (1 minute) and 86,400 (24 hours)
    /// seconds.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used to build and run
    /// the bot.
    role_arn: []const u8,

    /// A list of tags to add to the test alias for a bot. You can only add
    /// tags when you import a bot. You can't use the `UpdateAlias`
    /// operation to update tags. To update tags on the test alias, use the
    /// `TagResource` operation.
    test_bot_alias_tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_tags = "botTags",
        .data_privacy = "dataPrivacy",
        .error_log_settings = "errorLogSettings",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .role_arn = "roleArn",
        .test_bot_alias_tags = "testBotAliasTags",
    };
};
