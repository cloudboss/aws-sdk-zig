const aws = @import("aws");

const ParticipantDetails = @import("participant_details.zig").ParticipantDetails;
const ChatStreamingConfiguration = @import("chat_streaming_configuration.zig").ChatStreamingConfiguration;

/// Payload of chat properties to apply when starting a new contact.
pub const NewSessionDetails = struct {
    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Amazon Connect attributes. They
    /// can be accessed in flows just like any other contact attributes.
    ///
    /// There can be up to 32,768 UTF-8 bytes across all key-value pairs per
    /// contact. Attribute keys can include only
    /// alphanumeric, dash, and underscore characters.
    attributes: ?[]const aws.map.StringMapEntry,

    participant_details: ?ParticipantDetails,

    streaming_configuration: ?ChatStreamingConfiguration,

    /// The supported chat message content types. Supported types are `text/plain`,
    /// `text/markdown`, `application/json`,
    /// `application/vnd.amazonaws.connect.message.interactive`, and
    /// `application/vnd.amazonaws.connect.message.interactive.response`.
    ///
    /// Content types must always contain ` text/plain`. You can then put any other
    /// supported type in the
    /// list. For example, all the following lists are valid because they contain
    /// `text/plain`: `[text/plain,
    /// text/markdown, application/json]`, ` [text/markdown, text/plain]`,
    /// `[text/plain,
    /// application/json,
    /// application/vnd.amazonaws.connect.message.interactive.response]`.
    supported_messaging_content_types: ?[]const []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .participant_details = "ParticipantDetails",
        .streaming_configuration = "StreamingConfiguration",
        .supported_messaging_content_types = "SupportedMessagingContentTypes",
    };
};
