/// The output attachment type of the input device.
pub const InputDeviceOutputType = enum {
    none,
    medialive_input,
    mediaconnect_flow,

    pub const json_field_names = .{
        .none = "NONE",
        .medialive_input = "MEDIALIVE_INPUT",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
    };
};
