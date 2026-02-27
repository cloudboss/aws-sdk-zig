const aws = @import("aws");

/// Specifies the content and settings for a message template that can be used
/// in messages that are sent through the voice channel.
pub const VoiceTemplateRequest = struct {
    /// The text of the script to use in messages that are based on the message
    /// template, in plain text format.
    body: ?[]const u8,

    /// A JSON object that specifies the default values to use for message variables
    /// in the message template. This object is a set of key-value pairs. Each key
    /// defines a message variable in the template. The corresponding value defines
    /// the default value for that variable. When you create a message that's based
    /// on the template, you can override these defaults with message-specific and
    /// address-specific variables and values.
    default_substitutions: ?[]const u8,

    /// The code for the language to use when synthesizing the text of the script in
    /// messages that are based on the message template. For a list of supported
    /// languages and the code for each one, see the [Amazon Polly Developer
    /// Guide](https://docs.aws.amazon.com/polly/latest/dg/what-is.html).
    language_code: ?[]const u8,

    /// As of **22-05-2023** tags has been deprecated for update operations. After
    /// this date any value in tags is not processed and an error code is not
    /// returned. To manage tags we recommend using either
    /// [Tags](https://docs.aws.amazon.com/pinpoint/latest/apireference/tags-resource-arn.html) in the *API Reference for Amazon Pinpoint*, [resourcegroupstaggingapi](https://docs.aws.amazon.com/cli/latest/reference/resourcegroupstaggingapi/index.html) commands in the *AWS Command Line Interface Documentation* or [resourcegroupstaggingapi](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/resourcegroupstaggingapi/package-summary.html) in the *AWS SDK*.
    ///
    /// (Deprecated) A string-to-string map of key-value pairs that defines the tags
    /// to associate with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry,

    /// A custom description of the message template.
    template_description: ?[]const u8,

    /// The name of the voice to use when delivering messages that are based on the
    /// message template. For a list of supported voices, see the [Amazon Polly
    /// Developer Guide](https://docs.aws.amazon.com/polly/latest/dg/what-is.html).
    voice_id: ?[]const u8,

    pub const json_field_names = .{
        .body = "Body",
        .default_substitutions = "DefaultSubstitutions",
        .language_code = "LanguageCode",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .voice_id = "VoiceId",
    };
};
