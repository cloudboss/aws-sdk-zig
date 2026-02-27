/// The generative Q&A settings of an embedded Quick Sight console.
pub const DataQnAConfigurations = struct {
    /// The generative Q&A settings of an embedded Quick Sight console.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
