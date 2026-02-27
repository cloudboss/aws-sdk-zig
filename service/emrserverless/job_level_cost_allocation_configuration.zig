/// The configuration object that enables job level cost allocation.
pub const JobLevelCostAllocationConfiguration = struct {
    /// Enables job level cost allocation for the application.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
