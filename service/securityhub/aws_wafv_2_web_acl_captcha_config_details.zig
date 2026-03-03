const AwsWafv2WebAclCaptchaConfigImmunityTimePropertyDetails = @import("aws_wafv_2_web_acl_captcha_config_immunity_time_property_details.zig").AwsWafv2WebAclCaptchaConfigImmunityTimePropertyDetails;

/// Specifies how WAF should handle CAPTCHA evaluations for rules that don't
/// have their own `CaptchaConfig` settings.
pub const AwsWafv2WebAclCaptchaConfigDetails = struct {
    /// Determines how long a CAPTCHA timestamp in the token remains valid after the
    /// client successfully solves a CAPTCHA puzzle.
    immunity_time_property: ?AwsWafv2WebAclCaptchaConfigImmunityTimePropertyDetails = null,

    pub const json_field_names = .{
        .immunity_time_property = "ImmunityTimeProperty",
    };
};
