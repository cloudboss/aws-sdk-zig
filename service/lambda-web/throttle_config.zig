/// The throttling configuration for a web function endpoint.
pub const ThrottleConfig = struct {
    /// The maximum request rate per second for the endpoint. The value must be one
    /// of the following supported values: `0`, `100`, `200`, `300`, `400`, `500`,
    /// `600`, `700`, `800`, `900`, `1000`, `2000`, `3000`, `4000`, `5000`, `6000`,
    /// `7000`, `8000`, `9000`, or `10000`. The maximum effective value is also
    /// bounded by your account-level maximum total rate limit. There is no default
    /// value. If you don't specify a value, the throttling configuration is absent
    /// from the response. On an update, omit `throttleConfig` to keep the current
    /// value, or specify an empty object to clear a previously set value.
    rate_limit: ?i32 = null,

    pub const json_field_names = .{
        .rate_limit = "rateLimit",
    };
};
