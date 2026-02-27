const aws = @import("aws");

const DirectMessageConfiguration = @import("direct_message_configuration.zig").DirectMessageConfiguration;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;
const EndpointSendConfiguration = @import("endpoint_send_configuration.zig").EndpointSendConfiguration;

/// Specifies the configuration and other settings for a message to send to all
/// the endpoints that are associated with a list of users.
pub const SendUsersMessageRequest = struct {
    /// A map of custom attribute-value pairs. For a push notification, Amazon
    /// Pinpoint adds these attributes to the data.pinpoint object in the body of
    /// the notification payload. Amazon Pinpoint also provides these attributes in
    /// the events that it generates for users-messages deliveries.
    context: ?[]const aws.map.StringMapEntry,

    /// The settings and content for the default message and any default messages
    /// that you defined for specific channels.
    message_configuration: DirectMessageConfiguration,

    /// The message template to use for the message.
    template_configuration: ?TemplateConfiguration,

    /// The unique identifier for tracing the message. This identifier is visible to
    /// message recipients.
    trace_id: ?[]const u8,

    /// A map that associates user IDs with
    /// [EndpointSendConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-endpointsendconfiguration) objects. You can use an [EndpointSendConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-endpointsendconfiguration) object to tailor the message for a user by specifying settings such as content overrides and message variables.
    users: []const aws.map.MapEntry(EndpointSendConfiguration),

    pub const json_field_names = .{
        .context = "Context",
        .message_configuration = "MessageConfiguration",
        .template_configuration = "TemplateConfiguration",
        .trace_id = "TraceId",
        .users = "Users",
    };
};
