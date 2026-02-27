/// The state perssitence configuration of an embedded dashboard.
pub const StatePersistenceConfigurations = struct {
    /// Determines if a Quick Sight dashboard's state persistence settings are
    /// turned on or off.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
