const EmailAddressInsightsMailboxEvaluations = @import("email_address_insights_mailbox_evaluations.zig").EmailAddressInsightsMailboxEvaluations;
const EmailAddressInsightsVerdict = @import("email_address_insights_verdict.zig").EmailAddressInsightsVerdict;

/// Contains detailed validation information about an email address.
pub const MailboxValidation = struct {
    /// Specific validation checks performed on the email address.
    evaluations: ?EmailAddressInsightsMailboxEvaluations,

    /// Overall validity assessment with a conﬁdence verdict.
    is_valid: ?EmailAddressInsightsVerdict,

    pub const json_field_names = .{
        .evaluations = "Evaluations",
        .is_valid = "IsValid",
    };
};
