/// The state of the connection between the input device and AWS.
pub const InputDeviceConnectionState = enum {
    disconnected,
    connected,

    pub const json_field_names = .{
        .disconnected = "DISCONNECTED",
        .connected = "CONNECTED",
    };
};
