/// Contains details about the system-defined guardrail profile that you're
/// using with your guardrail for cross-Region inference.
///
/// For more information, see the [Amazon Bedrock User
/// Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region.html).
pub const GuardrailCrossRegionDetails = struct {
    /// The Amazon Resource Name (ARN) of the guardrail profile that you're using
    /// with your guardrail.
    guardrail_profile_arn: ?[]const u8,

    /// The ID of the guardrail profile that your guardrail is using. Profile
    /// availability depends on your current Amazon Web Services Region. For more
    /// information, see the [Amazon Bedrock User
    /// Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region-support.html).
    guardrail_profile_id: ?[]const u8,

    pub const json_field_names = .{
        .guardrail_profile_arn = "guardrailProfileArn",
        .guardrail_profile_id = "guardrailProfileId",
    };
};
