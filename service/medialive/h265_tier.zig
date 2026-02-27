/// H265 Tier
pub const H265Tier = enum {
    high,
    main,

    pub const json_field_names = .{
        .high = "HIGH",
        .main = "MAIN",
    };
};
