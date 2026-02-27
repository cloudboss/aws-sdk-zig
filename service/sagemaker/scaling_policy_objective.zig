/// An object where you specify the anticipated traffic pattern for an endpoint.
pub const ScalingPolicyObjective = struct {
    /// The maximum number of expected requests to your endpoint per minute.
    max_invocations_per_minute: ?i32,

    /// The minimum number of expected requests to your endpoint per minute.
    min_invocations_per_minute: ?i32,

    pub const json_field_names = .{
        .max_invocations_per_minute = "MaxInvocationsPerMinute",
        .min_invocations_per_minute = "MinInvocationsPerMinute",
    };
};
