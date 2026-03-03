/// A configuration for logging events.
pub const LogConfiguration = struct {
    /// Indicates whether logging is enabled.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
