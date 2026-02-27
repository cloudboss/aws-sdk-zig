/// An update to the connector's scale-in policy.
pub const ScaleInPolicyUpdate = struct {
    /// The target CPU utilization percentage threshold at which you want connector
    /// scale in to be triggered.
    cpu_utilization_percentage: i32 = 0,

    pub const json_field_names = .{
        .cpu_utilization_percentage = "cpuUtilizationPercentage",
    };
};
