/// Mpeg2 Display Ratio
pub const Mpeg2DisplayRatio = enum {
    displayratio16_x9,
    displayratio4_x3,

    pub const json_field_names = .{
        .displayratio16_x9 = "DISPLAYRATIO16X9",
        .displayratio4_x3 = "DISPLAYRATIO4X3",
    };
};
