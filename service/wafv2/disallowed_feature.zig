/// A WAF feature that is not supported by the CloudFront pricing plan
/// associated with the web ACL.
pub const DisallowedFeature = struct {
    /// The name of the disallowed WAF feature.
    feature: ?[]const u8 = null,

    /// The name of the CloudFront pricing plan required to use the WAF feature.
    required_pricing_plan: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature = "Feature",
        .required_pricing_plan = "RequiredPricingPlan",
    };
};
