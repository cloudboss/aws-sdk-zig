const aws = @import("aws");

const InAppMessageContent = @import("in_app_message_content.zig").InAppMessageContent;
const Layout = @import("layout.zig").Layout;

/// InApp Template Request.
pub const InAppTemplateRequest = struct {
    /// The content of the message, can include up to 5 modals. Each modal must
    /// contain a message, a header, and background color. ImageUrl and buttons are
    /// optional.
    content: ?[]const InAppMessageContent = null,

    /// Custom config to be sent to client.
    custom_config: ?[]const aws.map.StringMapEntry = null,

    /// The layout of the message.
    layout: ?Layout = null,

    /// As of **22-05-2023** tags has been deprecated for update operations. After
    /// this date any value in tags is not processed and an error code is not
    /// returned. To manage tags we recommend using either
    /// [Tags](https://docs.aws.amazon.com/pinpoint/latest/apireference/tags-resource-arn.html) in the *API Reference for Amazon Pinpoint*, [resourcegroupstaggingapi](https://docs.aws.amazon.com/cli/latest/reference/resourcegroupstaggingapi/index.html) commands in the *AWS Command Line Interface Documentation* or [resourcegroupstaggingapi](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/resourcegroupstaggingapi/package-summary.html) in the *AWS SDK*.
    ///
    /// (Deprecated) A string-to-string map of key-value pairs that defines the tags
    /// to associate with the message template. Each tag consists of a required tag
    /// key and an associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The description of the template.
    template_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "Content",
        .custom_config = "CustomConfig",
        .layout = "Layout",
        .tags = "tags",
        .template_description = "TemplateDescription",
    };
};
