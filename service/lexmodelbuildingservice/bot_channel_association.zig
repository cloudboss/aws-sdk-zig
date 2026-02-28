const aws = @import("aws");

const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const ChannelType = @import("channel_type.zig").ChannelType;

/// Represents an association between an Amazon Lex bot and an external
/// messaging platform.
pub const BotChannelAssociation = struct {
    /// An alias pointing to the specific version of the Amazon Lex bot to which
    /// this association is being made.
    bot_alias: ?[]const u8,

    /// Provides information necessary to communicate with the messaging
    /// platform.
    bot_configuration: ?[]const aws.map.StringMapEntry,

    /// The name of the Amazon Lex bot to which this association is being made.
    ///
    /// Currently, Amazon Lex supports associations with Facebook and Slack,
    /// and Twilio.
    bot_name: ?[]const u8,

    /// The date that the association between the Amazon Lex bot and the channel
    /// was created.
    created_date: ?i64,

    /// A text description of the association you are creating.
    description: ?[]const u8,

    /// If `status` is `FAILED`, Amazon Lex provides the
    /// reason that it failed to create the association.
    failure_reason: ?[]const u8,

    /// The name of the association between the bot and the channel.
    name: ?[]const u8,

    /// The status of the bot channel.
    ///
    /// * `CREATED` - The channel has been created and is
    /// ready for use.
    ///
    /// * `IN_PROGRESS` - Channel creation is in
    /// progress.
    ///
    /// * `FAILED` - There was an error creating the channel.
    /// For information about the reason for the failure, see the
    /// `failureReason` field.
    status: ?ChannelStatus,

    /// Specifies the type of association by indicating the type of channel
    /// being established between the Amazon Lex bot and the external messaging
    /// platform.
    @"type": ?ChannelType,

    pub const json_field_names = .{
        .bot_alias = "botAlias",
        .bot_configuration = "botConfiguration",
        .bot_name = "botName",
        .created_date = "createdDate",
        .description = "description",
        .failure_reason = "failureReason",
        .name = "name",
        .status = "status",
        .@"type" = "type",
    };
};
