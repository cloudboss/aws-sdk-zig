/// Describes the parameters of a rate limit.
pub const RateLimiterModuleParameters = struct {
    /// The transactions per second rate limit.
    tps: ?f32 = null,

    pub const json_field_names = .{
        .tps = "tps",
    };
};
