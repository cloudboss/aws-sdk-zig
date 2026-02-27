const aws = @import("aws");

/// Specifies the content and settings for a message template that can be used
/// in text messages that are sent through the SMS channel.
pub const SMSTemplateRequest = struct {
    /// The message body to use in text messages that are based on the message
    /// template.
    body: ?[]const u8,

    /// A JSON object that specifies the default values to use for message variables
    /// in the message template. This object is a set of key-value pairs. Each key
    /// defines a message variable in the template. The corresponding value defines
    /// the default value for that variable. When you create a message that's based
    /// on the template, you can override these defaults with message-specific and
    /// address-specific variables and values.
    default_substitutions: ?[]const u8,

    /// The unique identifier for the recommender model to use for the message
    /// template. Amazon Pinpoint uses this value to determine how to retrieve and
    /// process data from a recommender model when it sends messages that use the
    /// template, if the template contains message variables for recommendation
    /// data.
    recommender_id: ?[]const u8,

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

    pub const json_field_names = .{
        .body = "Body",
        .default_substitutions = "DefaultSubstitutions",
        .recommender_id = "RecommenderId",
        .tags = "tags",
        .template_description = "TemplateDescription",
    };
};
