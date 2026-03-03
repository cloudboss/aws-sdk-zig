/// List of customer gateway devices that have a sample configuration file
/// available for
/// use. You can also see the list of device types with sample configuration
/// files available
/// under [Your customer
/// gateway device](https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html)
/// in the *Amazon Web Services Site-to-Site VPN User Guide*.
pub const VpnConnectionDeviceType = struct {
    /// Customer gateway device platform.
    platform: ?[]const u8 = null,

    /// Customer gateway device software version.
    software: ?[]const u8 = null,

    /// Customer gateway device vendor.
    vendor: ?[]const u8 = null,

    /// Customer gateway device identifier.
    vpn_connection_device_type_id: ?[]const u8 = null,
};
