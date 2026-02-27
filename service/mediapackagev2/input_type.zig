pub const InputType = enum {
    hls,
    cmaf,

    pub const json_field_names = .{
        .hls = "HLS",
        .cmaf = "CMAF",
    };
};
