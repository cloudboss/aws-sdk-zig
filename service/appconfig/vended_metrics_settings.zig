/// The configuration settings for vended metrics in your AppConfig account.
pub const VendedMetricsSettings = struct {
    /// Specifies whether vended metrics are enabled for the account.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
