/// Configuration for linear deployment strategy that shifts production traffic
/// in equal percentage increments with configurable wait times between each
/// step until 100% of traffic is shifted to the new service revision. This is
/// only valid when you run `CreateService` or `UpdateService` with
/// `deploymentController` set to `ECS` and a `deploymentConfiguration` with a
/// strategy set to `LINEAR`.
pub const LinearConfiguration = struct {
    /// The amount of time in minutes to wait between each traffic shifting step
    /// during a linear deployment. Valid values are 0 to 1440 minutes (24 hours).
    /// The default value is 6. This bake time is not applied after reaching 100
    /// percent traffic.
    step_bake_time_in_minutes: ?i32 = null,

    /// The percentage of production traffic to shift in each step during a linear
    /// deployment. Valid values are multiples of 0.1 from 3.0 to 100.0. The default
    /// value is 10.0.
    step_percent: ?f64 = null,

    pub const json_field_names = .{
        .step_bake_time_in_minutes = "stepBakeTimeInMinutes",
        .step_percent = "stepPercent",
    };
};
