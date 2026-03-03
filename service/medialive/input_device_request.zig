/// Settings for an input device.
pub const InputDeviceRequest = struct {
    /// The unique ID for the device.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
