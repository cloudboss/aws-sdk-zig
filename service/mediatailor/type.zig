pub const Type = enum {
    dash,
    hls,

    pub const json_field_names = .{
        .dash = "DASH",
        .hls = "HLS",
    };
};
