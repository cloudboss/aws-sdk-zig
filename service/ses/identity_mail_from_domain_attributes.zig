const BehaviorOnMXFailure = @import("behavior_on_mx_failure.zig").BehaviorOnMXFailure;
const CustomMailFromStatus = @import("custom_mail_from_status.zig").CustomMailFromStatus;

/// Represents the custom MAIL FROM domain attributes of a verified identity
/// (email
/// address or domain).
pub const IdentityMailFromDomainAttributes = struct {
    /// The action that Amazon SES takes if it cannot successfully read the required
    /// MX record when
    /// you send an email. A value of `UseDefaultValue` indicates that if Amazon SES
    /// cannot read the required MX record, it uses amazonses.com (or a subdomain of
    /// that) as
    /// the MAIL FROM domain. A value of `RejectMessage` indicates that if Amazon
    /// SES
    /// cannot read the required MX record, Amazon SES returns a
    /// `MailFromDomainNotVerified` error and does not send the email.
    ///
    /// The custom MAIL FROM setup states that result in this behavior are
    /// `Pending`, `Failed`, and `TemporaryFailure`.
    behavior_on_mx_failure: BehaviorOnMXFailure,

    /// The custom MAIL FROM domain that the identity is configured to use.
    mail_from_domain: []const u8,

    /// The state that indicates whether Amazon SES has successfully read the MX
    /// record required
    /// for custom MAIL FROM domain setup. If the state is `Success`, Amazon SES
    /// uses the
    /// specified custom MAIL FROM domain when the verified identity sends an email.
    /// All other
    /// states indicate that Amazon SES takes the action described by
    /// `BehaviorOnMXFailure`.
    mail_from_domain_status: CustomMailFromStatus,
};
