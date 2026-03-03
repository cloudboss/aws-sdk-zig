const ImmunityTimeProperty = @import("immunity_time_property.zig").ImmunityTimeProperty;

/// Specifies how WAF should handle `Challenge` evaluations. This is
/// available at the web ACL level and in each rule.
pub const ChallengeConfig = struct {
    /// Determines how long a challenge timestamp in the token remains valid after
    /// the client
    /// successfully responds to a challenge.
    immunity_time_property: ?ImmunityTimeProperty = null,

    pub const json_field_names = .{
        .immunity_time_property = "ImmunityTimeProperty",
    };
};
