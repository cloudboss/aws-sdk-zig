/// Options for configuring service software updates for a domain.
pub const SoftwareUpdateOptions = struct {
    /// Whether automatic service software updates are enabled for the domain.
    auto_software_update_enabled: ?bool = null,

    pub const json_field_names = .{
        .auto_software_update_enabled = "AutoSoftwareUpdateEnabled",
    };
};
