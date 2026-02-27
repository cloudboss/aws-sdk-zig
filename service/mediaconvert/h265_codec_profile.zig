/// Represents the Profile and Tier, per the HEVC (H.265) specification.
/// Selections are grouped as [Profile] / [Tier], so "Main/High" represents Main
/// Profile with High Tier. 4:2:2 profiles are only available with the HEVC
/// 4:2:2 License.
pub const H265CodecProfile = enum {
    main_main,
    main_high,
    main10_main,
    main10_high,
    main_422_8_bit_main,
    main_422_8_bit_high,
    main_422_10_bit_main,
    main_422_10_bit_high,

    pub const json_field_names = .{
        .main_main = "MAIN_MAIN",
        .main_high = "MAIN_HIGH",
        .main10_main = "MAIN10_MAIN",
        .main10_high = "MAIN10_HIGH",
        .main_422_8_bit_main = "MAIN_422_8BIT_MAIN",
        .main_422_8_bit_high = "MAIN_422_8BIT_HIGH",
        .main_422_10_bit_main = "MAIN_422_10BIT_MAIN",
        .main_422_10_bit_high = "MAIN_422_10BIT_HIGH",
    };
};
