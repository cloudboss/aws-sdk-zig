/// The Wi-Fi Simple Setup configuration for the managed thing, which defines
/// provisioning capabilities and timeout settings.
pub const WiFiSimpleSetupConfiguration = struct {
    /// Indicates whether the device can act as a provisionee in Wi-Fi Simple Setup,
    /// allowing it to be configured by other devices.
    enable_as_provisionee: ?bool,

    /// Indicates whether the device can act as a provisioner in Wi-Fi Simple Setup,
    /// allowing it to configure other devices.
    enable_as_provisioner: ?bool,

    /// The timeout duration in minutes for Wi-Fi Simple Setup. Valid range is 5 to
    /// 15 minutes.
    timeout_in_minutes: ?i32,

    pub const json_field_names = .{
        .enable_as_provisionee = "EnableAsProvisionee",
        .enable_as_provisioner = "EnableAsProvisioner",
        .timeout_in_minutes = "TimeoutInMinutes",
    };
};
