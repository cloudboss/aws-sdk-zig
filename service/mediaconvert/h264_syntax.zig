/// Produces a bitstream compliant with SMPTE RP-2027.
pub const H264Syntax = enum {
    default,
    rp2027,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .rp2027 = "RP2027",
    };
};
