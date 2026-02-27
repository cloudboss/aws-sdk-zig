/// The scale-in policy for the connector.
pub const ScaleInPolicy = struct {
    /// Specifies the CPU utilization percentage threshold at which you want
    /// connector scale in to be triggered.
    cpu_utilization_percentage: i32 = 0,

    pub const json_field_names = .{
        .cpu_utilization_percentage = "cpuUtilizationPercentage",
    };
};
