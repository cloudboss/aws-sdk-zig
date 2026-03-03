const DeviceiSCSIAttributes = @import("devicei_scsi_attributes.zig").DeviceiSCSIAttributes;

/// Represents a device object associated with a tape gateway.
pub const VTLDevice = struct {
    /// A list of iSCSI information about a VTL device.
    devicei_scsi_attributes: ?DeviceiSCSIAttributes = null,

    /// Specifies the unique Amazon Resource Name (ARN) of the device (tape drive or
    /// media
    /// changer).
    vtl_device_arn: ?[]const u8 = null,

    /// Specifies the model number of device that the VTL device emulates.
    vtl_device_product_identifier: ?[]const u8 = null,

    /// Specifies the type of device that the VTL device emulates.
    vtl_device_type: ?[]const u8 = null,

    /// Specifies the vendor of the device that the VTL device object emulates.
    vtl_device_vendor: ?[]const u8 = null,

    pub const json_field_names = .{
        .devicei_scsi_attributes = "DeviceiSCSIAttributes",
        .vtl_device_arn = "VTLDeviceARN",
        .vtl_device_product_identifier = "VTLDeviceProductIdentifier",
        .vtl_device_type = "VTLDeviceType",
        .vtl_device_vendor = "VTLDeviceVendor",
    };
};
