/// H265 Profile
pub const H265Profile = enum {
    main,
    main_10_bit,

    pub const json_field_names = .{
        .main = "MAIN",
        .main_10_bit = "MAIN_10BIT",
    };
};
