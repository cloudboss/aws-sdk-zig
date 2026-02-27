pub const LinuxSubscriptionsDiscovery = enum {
    /// Enabled LinuxSubscriptionsDiscovery
    enabled,
    /// Disabled LinuxSubscriptionsDiscovery
    disabled,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .disabled = "Disabled",
    };
};
