const aws = @import("aws");

const ChannelType = @import("channel_type.zig").ChannelType;

/// Specifies address-based configuration settings for a message that's sent
/// directly to an endpoint.
pub const AddressConfiguration = struct {
    /// The message body to use instead of the default message body. This value
    /// overrides the default message body.
    body_override: ?[]const u8,

    /// The channel to use when sending the message.
    channel_type: ?ChannelType,

    /// An object that maps custom attributes to attributes for the address and is
    /// attached to the message. Attribute names are case sensitive.
    ///
    /// For a push notification, this payload is added to the data.pinpoint object.
    /// For an email or text message, this payload is added to email/SMS delivery
    /// receipt event attributes.
    context: ?[]const aws.map.StringMapEntry,

    /// The raw, JSON-formatted string to use as the payload for the message. If
    /// specified, this value overrides all other values for the message.
    raw_content: ?[]const u8,

    /// A map of the message variables to merge with the variables specified by
    /// properties of the DefaultMessage object. The variables specified in this map
    /// take precedence over all other variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8),

    /// The message title to use instead of the default message title. This value
    /// overrides the default message title.
    title_override: ?[]const u8,

    pub const json_field_names = .{
        .body_override = "BodyOverride",
        .channel_type = "ChannelType",
        .context = "Context",
        .raw_content = "RawContent",
        .substitutions = "Substitutions",
        .title_override = "TitleOverride",
    };
};
