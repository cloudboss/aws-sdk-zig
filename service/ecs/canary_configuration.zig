/// Configuration for a canary deployment strategy that shifts a fixed
/// percentage of traffic to
/// the new service revision, waits for a specified bake time, then shifts the
/// remaining
/// traffic.
///
/// This is only valid when you run `CreateService` or
/// `UpdateService` with `deploymentController` set to
/// `ECS` and a `deploymentConfiguration` with a strategy set to
/// `CANARY`.
pub const CanaryConfiguration = struct {
    /// The amount of time in minutes to wait during the canary phase before
    /// shifting the
    /// remaining production traffic to the new service revision. Valid values are 0
    /// to 1440
    /// minutes (24 hours). The default value is 10.
    canary_bake_time_in_minutes: ?i32 = null,

    /// The percentage of production traffic to shift to the new service revision
    /// during the canary phase. Valid values are multiples of 0.1 from 0.1 to
    /// 100.0. The default value is 5.0.
    canary_percent: ?f64 = null,

    pub const json_field_names = .{
        .canary_bake_time_in_minutes = "canaryBakeTimeInMinutes",
        .canary_percent = "canaryPercent",
    };
};
