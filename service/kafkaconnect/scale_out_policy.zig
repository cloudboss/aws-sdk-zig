/// The scale-out policy for the connector.
pub const ScaleOutPolicy = struct {
    /// The CPU utilization percentage threshold at which you want connector scale
    /// out to be triggered.
    cpu_utilization_percentage: i32 = 0,

    pub const json_field_names = .{
        .cpu_utilization_percentage = "cpuUtilizationPercentage",
    };
};
