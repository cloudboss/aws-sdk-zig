/// Sets additional capacity units configured for your
/// rescore execution plan. A rescore execution plan is an
/// Amazon Kendra Intelligent Ranking resource used for
/// provisioning the `Rescore` API. You can add and
/// remove capacity units to fit your usage requirements.
pub const CapacityUnitsConfiguration = struct {
    /// The amount of extra capacity for your rescore execution
    /// plan.
    ///
    /// A single extra capacity unit for a rescore execution
    /// plan provides 0.01 rescore requests per second. You can add
    /// up to 1000 extra capacity units.
    rescore_capacity_units: i32,

    pub const json_field_names = .{
        .rescore_capacity_units = "RescoreCapacityUnits",
    };
};
