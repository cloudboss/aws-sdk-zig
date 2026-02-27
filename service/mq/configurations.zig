const ConfigurationId = @import("configuration_id.zig").ConfigurationId;

/// Broker configuration information
pub const Configurations = struct {
    /// The broker's current configuration.
    current: ?ConfigurationId,

    /// The history of configurations applied to the broker.
    history: ?[]const ConfigurationId,

    /// The broker's pending configuration.
    pending: ?ConfigurationId,

    pub const json_field_names = .{
        .current = "Current",
        .history = "History",
        .pending = "Pending",
    };
};
