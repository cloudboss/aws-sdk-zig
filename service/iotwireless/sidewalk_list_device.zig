const CertificateList = @import("certificate_list.zig").CertificateList;
const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;
const WirelessDeviceSidewalkStatus = @import("wireless_device_sidewalk_status.zig").WirelessDeviceSidewalkStatus;

/// Sidewalk object used by list functions.
pub const SidewalkListDevice = struct {
    /// The Sidewalk Amazon ID.
    amazon_id: ?[]const u8 = null,

    /// The sidewalk device certificates for Ed25519 and P256r1.
    device_certificates: ?[]const CertificateList = null,

    /// Sidewalk object used by list functions.
    device_profile_id: ?[]const u8 = null,

    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning = null,

    /// The sidewalk device identification.
    sidewalk_id: ?[]const u8 = null,

    /// The Sidewalk manufacturing series number.
    sidewalk_manufacturing_sn: ?[]const u8 = null,

    /// The status of the Sidewalk devices, such as provisioned or registered.
    status: ?WirelessDeviceSidewalkStatus = null,

    pub const json_field_names = .{
        .amazon_id = "AmazonId",
        .device_certificates = "DeviceCertificates",
        .device_profile_id = "DeviceProfileId",
        .positioning = "Positioning",
        .sidewalk_id = "SidewalkId",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
        .status = "Status",
    };
};
