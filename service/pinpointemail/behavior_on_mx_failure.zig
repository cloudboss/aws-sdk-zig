/// The action that you want Amazon Pinpoint to take if it can't read the
/// required MX record for a
/// custom MAIL FROM domain. When you set this value to `UseDefaultValue`,
/// Amazon Pinpoint
/// uses *amazonses.com* as the MAIL FROM domain. When you set this value
/// to `RejectMessage`, Amazon Pinpoint returns a `MailFromDomainNotVerified`
/// error, and doesn't attempt to deliver the email.
///
/// These behaviors are taken when the custom MAIL FROM domain configuration is
/// in the
/// `Pending`, `Failed`, and `TemporaryFailure`
/// states.
pub const BehaviorOnMxFailure = enum {
    use_default_value,
    reject_message,

    pub const json_field_names = .{
        .use_default_value = "USE_DEFAULT_VALUE",
        .reject_message = "REJECT_MESSAGE",
    };
};
