/// The system-defined guardrail profile that you're using with your guardrail.
/// Guardrail profiles define the destination Amazon Web Services Regions where
/// guardrail inference requests can be automatically routed. Using guardrail
/// profiles helps maintain guardrail performance and reliability when demand
/// increases.
///
/// For more information, see the [Amazon Bedrock User
/// Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region.html).
pub const GuardrailCrossRegionConfig = struct {
    /// The ID or Amazon Resource Name (ARN) of the guardrail profile that your
    /// guardrail is using. Guardrail profile availability depends on your current
    /// Amazon Web Services Region. For more information, see the [Amazon Bedrock
    /// User
    /// Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region-support.html).
    guardrail_profile_identifier: []const u8,

    pub const json_field_names = .{
        .guardrail_profile_identifier = "guardrailProfileIdentifier",
    };
};
