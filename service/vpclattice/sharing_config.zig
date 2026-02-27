/// Specifies if the service network should be enabled for sharing.
pub const SharingConfig = struct {
    /// Specifies if the service network is enabled for sharing.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
