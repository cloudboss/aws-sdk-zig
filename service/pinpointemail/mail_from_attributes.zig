const BehaviorOnMxFailure = @import("behavior_on_mx_failure.zig").BehaviorOnMxFailure;
const MailFromDomainStatus = @import("mail_from_domain_status.zig").MailFromDomainStatus;

/// A list of attributes that are associated with a MAIL FROM domain.
pub const MailFromAttributes = struct {
    /// The action that Amazon Pinpoint to takes if it can't read the required MX
    /// record for a custom
    /// MAIL FROM domain. When you set this value to `UseDefaultValue`, Amazon
    /// Pinpoint uses
    /// *amazonses.com* as the MAIL FROM domain. When you set this value
    /// to `RejectMessage`, Amazon Pinpoint returns a `MailFromDomainNotVerified`
    /// error, and doesn't attempt to deliver the email.
    ///
    /// These behaviors are taken when the custom MAIL FROM domain configuration is
    /// in the
    /// `Pending`, `Failed`, and `TemporaryFailure`
    /// states.
    behavior_on_mx_failure: BehaviorOnMxFailure,

    /// The name of a domain that an email identity uses as a custom MAIL FROM
    /// domain.
    mail_from_domain: []const u8,

    /// The status of the MAIL FROM domain. This status can have the following
    /// values:
    ///
    /// * `PENDING` – Amazon Pinpoint hasn't started searching for the MX record
    /// yet.
    ///
    /// * `SUCCESS` – Amazon Pinpoint detected the required MX record for the
    /// MAIL FROM domain.
    ///
    /// * `FAILED` – Amazon Pinpoint can't find the required MX record, or the
    /// record no longer exists.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue occurred, which
    /// prevented Amazon Pinpoint from determining the status of the MAIL FROM
    /// domain.
    mail_from_domain_status: MailFromDomainStatus,

    pub const json_field_names = .{
        .behavior_on_mx_failure = "BehaviorOnMxFailure",
        .mail_from_domain = "MailFromDomain",
        .mail_from_domain_status = "MailFromDomainStatus",
    };
};
