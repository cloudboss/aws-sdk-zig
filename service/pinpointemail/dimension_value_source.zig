/// The location where Amazon Pinpoint finds the value of a dimension to publish
/// to Amazon CloudWatch. If you
/// want Amazon Pinpoint to use the message tags that you specify using an
/// X-SES-MESSAGE-TAGS header
/// or a parameter to the SendEmail/SendRawEmail API, choose `messageTag`. If
/// you
/// want Amazon Pinpoint to use your own email headers, choose `emailHeader`. If
/// you want
/// Amazon Pinpoint to use link tags, choose `linkTags`.
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
