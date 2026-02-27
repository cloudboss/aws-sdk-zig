const EmailAddressInsightsVerdict = @import("email_address_insights_verdict.zig").EmailAddressInsightsVerdict;

/// Contains individual validation checks performed on an email address.
pub const EmailAddressInsightsMailboxEvaluations = struct {
    /// Checks that the domain exists, has valid DNS records, and is conﬁgured to
    /// receive email.
    has_valid_dns_records: ?EmailAddressInsightsVerdict,

    /// Checks that the email address follows proper RFC standards and contains
    /// valid characters in the correct format.
    has_valid_syntax: ?EmailAddressInsightsVerdict,

    /// Checks disposable or temporary email addresses that could negatively impact
    /// your sender reputation.
    is_disposable: ?EmailAddressInsightsVerdict,

    /// Checks if the input appears to be random text.
    is_random_input: ?EmailAddressInsightsVerdict,

    /// Identiﬁes role-based addresses (such as admin@, support@, or info@) that may
    /// have lower engagement rates.
    is_role_address: ?EmailAddressInsightsVerdict,

    /// Checks that the mailbox exists and can receive messages without actually
    /// sending an email.
    mailbox_exists: ?EmailAddressInsightsVerdict,

    pub const json_field_names = .{
        .has_valid_dns_records = "HasValidDnsRecords",
        .has_valid_syntax = "HasValidSyntax",
        .is_disposable = "IsDisposable",
        .is_random_input = "IsRandomInput",
        .is_role_address = "IsRoleAddress",
        .mailbox_exists = "MailboxExists",
    };
};
