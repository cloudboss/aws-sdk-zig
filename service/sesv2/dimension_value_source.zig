/// The location where the Amazon SES API v2 finds the value of a dimension to
/// publish to Amazon CloudWatch. To
/// use the message tags that you specify using an `X-SES-MESSAGE-TAGS` header
/// or
/// a parameter to the `SendEmail` or `SendRawEmail` API, choose
/// `messageTag`. To use your own email headers, choose
/// `emailHeader`. To use link tags, choose `linkTags`.
pub const DimensionValueSource = enum {
    message_tag,
    email_header,
    link_tag,

    pub const json_field_names = .{
        .message_tag = "MESSAGE_TAG",
        .email_header = "EMAIL_HEADER",
        .link_tag = "LINK_TAG",
    };
};
