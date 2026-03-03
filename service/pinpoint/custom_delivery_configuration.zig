const __EndpointTypesElement = @import("endpoint_types_element.zig").__EndpointTypesElement;

/// Specifies the delivery configuration settings for sending a campaign or
/// campaign treatment through a custom channel. This object is required if you
/// use the CampaignCustomMessage object to define the message to send for the
/// campaign or campaign treatment.
pub const CustomDeliveryConfiguration = struct {
    /// The destination to send the campaign or treatment to. This value can be one
    /// of the following:
    ///
    /// * The name or Amazon Resource Name (ARN) of an AWS Lambda function to invoke
    ///   to handle delivery of the campaign or treatment.
    /// * The URL for a web application or service that supports HTTPS and can
    ///   receive the message. The URL has to be a full URL, including the HTTPS
    ///   protocol.
    delivery_uri: []const u8,

    /// The types of endpoints to send the campaign or treatment to. Each valid
    /// value maps to a type of channel that you can associate with an endpoint by
    /// using the ChannelType property of an endpoint.
    endpoint_types: ?[]const __EndpointTypesElement = null,

    pub const json_field_names = .{
        .delivery_uri = "DeliveryUri",
        .endpoint_types = "EndpointTypes",
    };
};
