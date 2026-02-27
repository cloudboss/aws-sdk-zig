/// The scan type of the video source.
pub const InputDeviceScanType = enum {
    interlaced,
    progressive,

    pub const json_field_names = .{
        .interlaced = "INTERLACED",
        .progressive = "PROGRESSIVE",
    };
};
