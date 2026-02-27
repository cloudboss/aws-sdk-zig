/// The generative BI authoring settings of an embedded Quick Sight console.
pub const GenerativeAuthoringConfigurations = struct {
    /// The generative BI authoring settings of an embedded Quick Sight console.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
