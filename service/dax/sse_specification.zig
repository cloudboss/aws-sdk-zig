/// Represents the settings used to enable server-side encryption.
pub const SSESpecification = struct {
    /// Indicates whether server-side encryption is enabled (true) or disabled
    /// (false) on
    /// the cluster.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
