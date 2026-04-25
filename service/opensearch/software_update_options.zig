/// Options for configuring service software updates for a domain.
pub const SoftwareUpdateOptions = struct {
    /// Whether automatic service software updates are enabled for the domain.
    auto_software_update_enabled: ?bool = null,

    /// Whether the domain should use the latest service software version during a
    /// blue/green deployment. If enabled, the domain will automatically use the
    /// latest
    /// available service software when a blue/green deployment is triggered.
    use_latest_service_software_for_blue_green: ?bool = null,

    pub const json_field_names = .{
        .auto_software_update_enabled = "AutoSoftwareUpdateEnabled",
        .use_latest_service_software_for_blue_green = "UseLatestServiceSoftwareForBlueGreen",
    };
};
