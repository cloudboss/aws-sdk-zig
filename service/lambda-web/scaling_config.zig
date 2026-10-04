/// The scaling configuration for a web function endpoint.
pub const ScalingConfig = struct {
    /// The maximum number of concurrent execution environments for the endpoint.
    /// Minimum value of 2, maximum value of 10000. There is no default value. If
    /// you don't specify a value, the scaling configuration is absent from the
    /// response. On an update, omit `scalingConfig` to keep the current value, or
    /// specify an empty object to clear a previously set value.
    max_environments: ?i32 = null,

    pub const json_field_names = .{
        .max_environments = "maxEnvironments",
    };
};
