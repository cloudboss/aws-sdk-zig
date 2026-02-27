const CertificateList = @import("certificate_list.zig").CertificateList;
const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;
const WirelessDeviceSidewalkStatus = @import("wireless_device_sidewalk_status.zig").WirelessDeviceSidewalkStatus;

/// Sidewalk device object.
pub const SidewalkDevice = struct {
    amazon_id: ?[]const u8,

    /// The ID of the Sidewalk device profile.
    certificate_id: ?[]const u8,

    /// The sidewalk device certificates for Ed25519 and P256r1.
    device_certificates: ?[]const CertificateList,

    /// The ID of the Sidewalk device profile.
    device_profile_id: ?[]const u8,

    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning,

    /// The Sidewalk device private keys that will be used for onboarding the
    /// device.
    private_keys: ?[]const CertificateList,

    /// The sidewalk device identification.
    sidewalk_id: ?[]const u8,

    /// The Sidewalk manufacturing series number.
    sidewalk_manufacturing_sn: ?[]const u8,

    /// The Sidewalk device status, such as provisioned or registered.
    status: ?WirelessDeviceSidewalkStatus,

    pub const json_field_names = .{
        .amazon_id = "AmazonId",
        .certificate_id = "CertificateId",
        .device_certificates = "DeviceCertificates",
        .device_profile_id = "DeviceProfileId",
        .positioning = "Positioning",
        .private_keys = "PrivateKeys",
        .sidewalk_id = "SidewalkId",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
        .status = "Status",
    };
};
