/// Configuration.
pub const Configuration = struct {
    /// True to enable the configuration.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
