/// Provides information about the required target engine settings.
pub const RecommendationSettings = struct {
    /// The size of your target instance. Fleet Advisor calculates this value based
    /// on your
    /// data collection type, such as total capacity and resource utilization. Valid
    /// values
    /// include `"total-capacity"` and `"utilization"`.
    instance_sizing_type: []const u8,

    /// The deployment option for your target engine. For production databases,
    /// Fleet Advisor
    /// chooses Multi-AZ deployment. For development or test databases, Fleet
    /// Advisor chooses
    /// Single-AZ deployment. Valid values include `"development"` and
    /// `"production"`.
    workload_type: []const u8,

    pub const json_field_names = .{
        .instance_sizing_type = "InstanceSizingType",
        .workload_type = "WorkloadType",
    };
};
