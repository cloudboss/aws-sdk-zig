/// The type of resource that can be associated with a tenant. Can be one of the
/// following:
///
/// * `EMAIL_IDENTITY` - An email address or domain that you use to send email.
///
/// * `CONFIGURATION_SET` - A set of rules that you can apply to emails you
///   send.
///
/// * `EMAIL_TEMPLATE` - A template that defines the content of an email
///   message.
pub const ResourceType = enum {
    email_identity,
    configuration_set,
    email_template,

    pub const json_field_names = .{
        .email_identity = "EMAIL_IDENTITY",
        .configuration_set = "CONFIGURATION_SET",
        .email_template = "EMAIL_TEMPLATE",
    };
};
