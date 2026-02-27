const __EndpointTypesElement = @import("endpoint_types_element.zig").__EndpointTypesElement;
const JourneyCustomMessage = @import("journey_custom_message.zig").JourneyCustomMessage;

/// The settings for a custom message activity. This type of activity calls an
/// AWS Lambda function or web hook that sends messages to participants.
pub const CustomMessageActivity = struct {
    /// The destination to send the campaign or treatment to. This value can be one
    /// of the following:
    ///
    /// * The name or Amazon Resource Name (ARN) of an AWS Lambda function to invoke
    ///   to handle delivery of the campaign or treatment.
    /// * The URL for a web application or service that supports HTTPS and can
    ///   receive the message. The URL has to be a full URL, including the HTTPS
    ///   protocol.
    delivery_uri: ?[]const u8,

    /// The types of endpoints to send the custom message to. Each valid value maps
    /// to a type of channel that you can associate with an endpoint by using the
    /// ChannelType property of an endpoint.
    endpoint_types: ?[]const __EndpointTypesElement,

    /// Specifies the message data included in a custom channel message that's sent
    /// to participants in a journey.
    message_config: ?JourneyCustomMessage,

    /// The unique identifier for the next activity to perform, after Amazon
    /// Pinpoint calls the AWS Lambda function or web hook.
    next_activity: ?[]const u8,

    /// The name of the custom message template to use for the message. If
    /// specified, this value must match the name of an existing message template.
    template_name: ?[]const u8,

    /// The unique identifier for the version of the message template to use for the
    /// message. If specified, this value must match the identifier for an existing
    /// template version. To retrieve a list of versions and version identifiers for
    /// a template, use the Template Versions resource.
    ///
    /// If you don't specify a value for this property, Amazon Pinpoint uses the
    /// *active version* of the template. The *active version* is typically the
    /// version of a template that's been most recently reviewed and approved for
    /// use, depending on your workflow. It isn't necessarily the latest version of
    /// a template.
    template_version: ?[]const u8,

    pub const json_field_names = .{
        .delivery_uri = "DeliveryUri",
        .endpoint_types = "EndpointTypes",
        .message_config = "MessageConfig",
        .next_activity = "NextActivity",
        .template_name = "TemplateName",
        .template_version = "TemplateVersion",
    };
};
