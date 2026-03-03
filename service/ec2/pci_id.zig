/// Describes the data that identifies an Amazon FPGA image (AFI) on the PCI
/// bus.
pub const PciId = struct {
    /// The ID of the device.
    device_id: ?[]const u8 = null,

    /// The ID of the subsystem.
    subsystem_id: ?[]const u8 = null,

    /// The ID of the vendor for the subsystem.
    subsystem_vendor_id: ?[]const u8 = null,

    /// The ID of the vendor.
    vendor_id: ?[]const u8 = null,
};
