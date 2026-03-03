const aws = @import("aws");

const InAppMessageContent = @import("in_app_message_content.zig").InAppMessageContent;
const Layout = @import("layout.zig").Layout;
const TemplateType = @import("template_type.zig").TemplateType;

/// In-App Template Response.
pub const InAppTemplateResponse = struct {
    /// The resource arn of the template.
    arn: ?[]const u8 = null,

    /// The content of the message, can include up to 5 modals. Each modal must
    /// contain a message, a header, and background color. ImageUrl and buttons are
    /// optional.
    content: ?[]const InAppMessageContent = null,

    /// The creation date of the template.
    creation_date: []const u8,

    /// Custom config to be sent to client.
    custom_config: ?[]const aws.map.StringMapEntry = null,

    /// The last modified date of the template.
    last_modified_date: []const u8,

    /// The layout of the message.
    layout: ?Layout = null,

    /// A string-to-string map of key-value pairs that defines the tags to associate
    /// with the message template. Each tag consists of a required tag key and an
    /// associated tag value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The description of the template.
    template_description: ?[]const u8 = null,

    /// The name of the template.
    template_name: []const u8,

    /// The type of the template.
    template_type: TemplateType,

    /// The version id of the template.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .creation_date = "CreationDate",
        .custom_config = "CustomConfig",
        .last_modified_date = "LastModifiedDate",
        .layout = "Layout",
        .tags = "tags",
        .template_description = "TemplateDescription",
        .template_name = "TemplateName",
        .template_type = "TemplateType",
        .version = "Version",
    };
};
