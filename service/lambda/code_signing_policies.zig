const CodeSigningPolicy = @import("code_signing_policy.zig").CodeSigningPolicy;

/// Code signing configuration
/// [policies](https://docs.aws.amazon.com/lambda/latest/dg/configuration-codesigning.html#config-codesigning-policies) specify the validation failure action for signature mismatch or expiry.
pub const CodeSigningPolicies = struct {
    /// Code signing configuration policy for deployment validation failure. If you
    /// set the policy to `Enforce`, Lambda blocks the deployment request if
    /// signature validation checks fail. If you set the policy to `Warn`, Lambda
    /// allows the deployment and issues a new Amazon CloudWatch metric
    /// (`SignatureValidationErrors`) and also stores the warning in the CloudTrail
    /// log.
    ///
    /// Default value: `Warn`
    untrusted_artifact_on_deployment: ?CodeSigningPolicy,
};
