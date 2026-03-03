const aws = @import("aws");

/// Specifies the content, including message variables and attributes, to use in
/// a message that's sent directly to an endpoint.
pub const EndpointSendConfiguration = struct {
    /// The body of the message. If specified, this value overrides the default
    /// message body.
    body_override: ?[]const u8 = null,

    /// A map of custom attributes to attach to the message for the address.
    /// Attribute names are case sensitive.
    ///
    /// For a push notification, this payload is added to the data.pinpoint object.
    /// For an email or text message, this payload is added to email/SMS delivery
    /// receipt event attributes.
    context: ?[]const aws.map.StringMapEntry = null,

    /// The raw, JSON-formatted string to use as the payload for the message. If
    /// specified, this value overrides all other values for the message.
    raw_content: ?[]const u8 = null,

    /// A map of the message variables to merge with the variables specified for the
    /// default message (DefaultMessage.Substitutions). The variables specified in
    /// this map take precedence over all other variables.
    substitutions: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The title or subject line of the message. If specified, this value overrides
    /// the default message title or subject line.
    title_override: ?[]const u8 = null,

    pub const json_field_names = .{
        .body_override = "BodyOverride",
        .context = "Context",
        .raw_content = "RawContent",
        .substitutions = "Substitutions",
        .title_override = "TitleOverride",
    };
};
