/// Specify the Bit depth. You can choose 8-bit or 10-bit.
pub const Av1BitDepth = enum {
    bit_8,
    bit_10,

    pub const json_field_names = .{
        .bit_8 = "BIT_8",
        .bit_10 = "BIT_10",
    };
};
