const ContentType = @import("content_type.zig").ContentType;
const GenericAttachment = @import("generic_attachment.zig").GenericAttachment;

/// If you configure a response card when creating your bots, Amazon Lex
/// substitutes the session attributes and slot values that are available, and
/// then returns it. The response card can also come from a Lambda function (
/// `dialogCodeHook` and `fulfillmentActivity` on an
/// intent).
pub const ResponseCard = struct {
    /// The content type of the response.
    content_type: ?ContentType = null,

    /// An array of attachment objects representing options.
    generic_attachments: ?[]const GenericAttachment = null,

    /// The version of the response card format.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .generic_attachments = "genericAttachments",
        .version = "version",
    };
};
