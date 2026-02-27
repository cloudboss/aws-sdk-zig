/// H264 Syntax
pub const H264Syntax = enum {
    default,
    rp2027,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .rp2027 = "RP2027",
    };
};
