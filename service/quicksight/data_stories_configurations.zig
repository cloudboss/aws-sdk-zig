/// The data story settings of an embedded Quick Sight console.
pub const DataStoriesConfigurations = struct {
    /// The data story settings of an embedded Quick Sight console.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
