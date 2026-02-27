const ParameterDefinition = @import("parameter_definition.zig").ParameterDefinition;

/// This field only supports multi-tenant distributions. You can't specify this
/// field for standard distributions. For more information, see [Unsupported
/// features for SaaS Manager for Amazon
/// CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-config-options.html#unsupported-saas) in the *Amazon CloudFront Developer Guide*.
///
/// The configuration for a distribution tenant.
pub const TenantConfig = struct {
    /// The parameters that you specify for a distribution tenant.
    parameter_definitions: ?[]const ParameterDefinition,
};
