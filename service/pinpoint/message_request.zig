const aws = @import("aws");

const AddressConfiguration = @import("address_configuration.zig").AddressConfiguration;
const EndpointSendConfiguration = @import("endpoint_send_configuration.zig").EndpointSendConfiguration;
const DirectMessageConfiguration = @import("direct_message_configuration.zig").DirectMessageConfiguration;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;

/// Specifies the configuration and other settings for a message.
pub const MessageRequest = struct {
    /// A map of key-value pairs, where each key is an address and each value is an
    /// [AddressConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-addressconfiguration) object. An address can be a push notification token, a phone number, or an email address. You can use an [AddressConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-addressconfiguration) object to tailor the message for an address by specifying settings such as content overrides and message variables.
    addresses: ?[]const aws.map.MapEntry(AddressConfiguration) = null,

    /// A map of custom attributes to attach to the message. For a push
    /// notification, this payload is added to the data.pinpoint object. For an
    /// email or text message, this payload is added to email/SMS delivery receipt
    /// event attributes.
    context: ?[]const aws.map.StringMapEntry = null,

    /// A map of key-value pairs, where each key is an endpoint ID and each value is
    /// an
    /// [EndpointSendConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-endpointsendconfiguration) object. You can use an [EndpointSendConfiguration](https://docs.aws.amazon.com/pinpoint/latest/apireference/apps-application-id-messages.html#apps-application-id-messages-model-endpointsendconfiguration) object to tailor the message for an endpoint by specifying settings such as content overrides and message variables.
    endpoints: ?[]const aws.map.MapEntry(EndpointSendConfiguration) = null,

    /// The settings and content for the default message and any default messages
    /// that you defined for specific channels.
    message_configuration: DirectMessageConfiguration,

    /// The message template to use for the message.
    template_configuration: ?TemplateConfiguration = null,

    /// The unique identifier for tracing the message. This identifier is visible to
    /// message recipients.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .addresses = "Addresses",
        .context = "Context",
        .endpoints = "Endpoints",
        .message_configuration = "MessageConfiguration",
        .template_configuration = "TemplateConfiguration",
        .trace_id = "TraceId",
    };
};
