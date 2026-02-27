const MessageType = @import("message_type.zig").MessageType;
const EventDestination = @import("event_destination.zig").EventDestination;

/// Information related to a given configuration set in your Amazon Web Services
/// account.
pub const ConfigurationSetInformation = struct {
    /// The Resource Name (ARN) of the ConfigurationSet.
    configuration_set_arn: []const u8,

    /// The name of the ConfigurationSet.
    configuration_set_name: []const u8,

    /// The time when the ConfigurationSet was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// True if message feedback is enabled.
    default_message_feedback_enabled: ?bool,

    /// The type of message. Valid values are TRANSACTIONAL for messages that are
    /// critical or time-sensitive and PROMOTIONAL for messages that aren't critical
    /// or time-sensitive.
    default_message_type: ?MessageType,

    /// The default sender ID used by the ConfigurationSet.
    default_sender_id: ?[]const u8,

    /// An array of EventDestination objects that describe any events to log and
    /// where to log them.
    event_destinations: []const EventDestination,

    /// The unique identifier for the protect configuration.
    protect_configuration_id: ?[]const u8,

    pub const json_field_names = .{
        .configuration_set_arn = "ConfigurationSetArn",
        .configuration_set_name = "ConfigurationSetName",
        .created_timestamp = "CreatedTimestamp",
        .default_message_feedback_enabled = "DefaultMessageFeedbackEnabled",
        .default_message_type = "DefaultMessageType",
        .default_sender_id = "DefaultSenderId",
        .event_destinations = "EventDestinations",
        .protect_configuration_id = "ProtectConfigurationId",
    };
};
