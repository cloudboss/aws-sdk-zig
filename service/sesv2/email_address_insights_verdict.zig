const EmailAddressInsightsConfidenceVerdict = @import("email_address_insights_confidence_verdict.zig").EmailAddressInsightsConfidenceVerdict;

/// Contains the overall validation verdict for an email address.
pub const EmailAddressInsightsVerdict = struct {
    /// The confidence level of the validation verdict.
    confidence_verdict: ?EmailAddressInsightsConfidenceVerdict,

    pub const json_field_names = .{
        .confidence_verdict = "ConfidenceVerdict",
    };
};
