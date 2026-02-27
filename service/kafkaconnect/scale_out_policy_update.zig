/// An update to the connector's scale-out policy.
pub const ScaleOutPolicyUpdate = struct {
    /// The target CPU utilization percentage threshold at which you want connector
    /// scale out to be triggered.
    cpu_utilization_percentage: i32 = 0,

    pub const json_field_names = .{
        .cpu_utilization_percentage = "cpuUtilizationPercentage",
    };
};
