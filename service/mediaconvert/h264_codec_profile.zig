/// H.264 Profile. High 4:2:2 and 10-bit profiles are only available with the
/// AVC-I License.
pub const H264CodecProfile = enum {
    baseline,
    high,
    high_10_bit,
    high_422,
    high_422_10_bit,
    main,

    pub const json_field_names = .{
        .baseline = "BASELINE",
        .high = "HIGH",
        .high_10_bit = "HIGH_10BIT",
        .high_422 = "HIGH_422",
        .high_422_10_bit = "HIGH_422_10BIT",
        .main = "MAIN",
    };
};
