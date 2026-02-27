/// The state of the input device.
pub const InputDeviceState = enum {
    idle,
    streaming,

    pub const json_field_names = .{
        .idle = "IDLE",
        .streaming = "STREAMING",
    };
};
