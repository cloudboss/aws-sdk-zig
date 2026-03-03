/// Contains information about an EBS snapshot that was scanned for malware.
pub const EbsSnapshot = struct {
    /// The device name of the EBS snapshot that was scanned.
    device_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_name = "DeviceName",
    };
};
