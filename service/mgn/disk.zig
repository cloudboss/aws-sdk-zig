/// The disk identifier.
pub const Disk = struct {
    /// The amount of storage on the disk in bytes.
    bytes: i64 = 0,

    /// The disk or device name.
    device_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "bytes",
        .device_name = "deviceName",
    };
};
