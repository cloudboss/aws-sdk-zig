const ImmunityTimeProperty = @import("immunity_time_property.zig").ImmunityTimeProperty;

/// Specifies how WAF should handle `CAPTCHA` evaluations. This is
/// available at the web ACL level and in each rule.
pub const CaptchaConfig = struct {
    /// Determines how long a `CAPTCHA` timestamp in the token remains valid after
    /// the client
    /// successfully solves a `CAPTCHA` puzzle.
    immunity_time_property: ?ImmunityTimeProperty,

    pub const json_field_names = .{
        .immunity_time_property = "ImmunityTimeProperty",
    };
};
