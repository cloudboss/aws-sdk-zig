const aws = @import("aws");

/// The delivery parameters for the text channel, which delivers over SMS or
/// RCS.
pub const TextParameters = struct {
    /// A map of country-specific parameters that control one-time passcode
    /// delivery.
    destination_country_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The freeform message template used to render the one-time passcode for the
    /// SMS or RCS channels. The template must contain the code placeholder.
    inline_template_body: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_country_parameters = "destinationCountryParameters",
        .inline_template_body = "inlineTemplateBody",
    };
};
