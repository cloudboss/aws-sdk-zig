/// The codec to use on the video that the device produces.
pub const InputDeviceCodec = enum {
    hevc,
    avc,

    pub const json_field_names = .{
        .hevc = "HEVC",
        .avc = "AVC",
    };
};
