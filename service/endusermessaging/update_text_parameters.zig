const aws = @import("aws");

/// The updated delivery parameters for the text channel. Absent members
/// preserve the current value, and the empty sentinel on a member clears it.
pub const UpdateTextParameters = struct {
    /// The updated map of country-specific parameters that control one-time
    /// passcode delivery. An empty map clears the previously stored value.
    destination_country_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The updated freeform SMS or RCS template body. An empty string clears the
    /// previously stored value.
    inline_template_body: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_country_parameters = "destinationCountryParameters",
        .inline_template_body = "inlineTemplateBody",
    };
};
