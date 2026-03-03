/// Used for CAPTCHA and challenge token settings. Determines how long a CAPTCHA
/// or challenge timestamp remains valid after WAF updates it for a successful
/// CAPTCHA or challenge response.
pub const AwsWafv2WebAclCaptchaConfigImmunityTimePropertyDetails = struct {
    /// The amount of time, in seconds, that a CAPTCHA or challenge timestamp is
    /// considered valid by WAF.
    immunity_time: ?i64 = null,

    pub const json_field_names = .{
        .immunity_time = "ImmunityTime",
    };
};
