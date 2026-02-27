/// Used for CAPTCHA and challenge token settings. Determines
/// how long a `CAPTCHA` or challenge timestamp remains valid after WAF updates
/// it for a successful `CAPTCHA` or challenge response.
pub const ImmunityTimeProperty = struct {
    /// The amount of time, in seconds, that a `CAPTCHA` or challenge timestamp is
    /// considered valid by WAF. The default
    /// setting is 300.
    ///
    /// For the Challenge action, the minimum setting is 300.
    immunity_time: i64,

    pub const json_field_names = .{
        .immunity_time = "ImmunityTime",
    };
};
