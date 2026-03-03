/// Tunnel timeout configuration.
pub const TimeoutConfig = struct {
    /// The maximum amount of time (in minutes) a tunnel can remain open. If not
    /// specified,
    /// maxLifetimeTimeoutMinutes defaults to 720 minutes. Valid values are from 1
    /// minute to 12
    /// hours (720 minutes)
    max_lifetime_timeout_minutes: ?i32 = null,

    pub const json_field_names = .{
        .max_lifetime_timeout_minutes = "maxLifetimeTimeoutMinutes",
    };
};
