/// Session stickiness provides the ability to define multiple requests from a
/// single viewer as a single session. This prevents the potentially
/// inconsistent experience of sending some of a given user's requests to your
/// staging distribution, while others are sent to your primary distribution.
/// Define the session duration using TTL values.
pub const SessionStickinessConfig = struct {
    /// The amount of time after which you want sessions to cease if no requests are
    /// received. Allowed values are 300–3600 seconds (5–60 minutes).
    ///
    /// The value must be less than or equal to `MaximumTTL`.
    idle_ttl: i32,

    /// The maximum amount of time to consider requests from the viewer as being
    /// part of the same session. Allowed values are 300–3600 seconds (5–60
    /// minutes).
    ///
    /// The value must be greater than or equal to `IdleTTL`.
    maximum_ttl: i32,
};
