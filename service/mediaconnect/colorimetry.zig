pub const Colorimetry = enum {
    bt601,
    bt709,
    bt2020,
    bt2100,
    st2065_1,
    st2065_3,
    xyz,

    pub const json_field_names = .{
        .bt601 = "BT601",
        .bt709 = "BT709",
        .bt2020 = "BT2020",
        .bt2100 = "BT2100",
        .st2065_1 = "ST2065_1",
        .st2065_3 = "ST2065_3",
        .xyz = "XYZ",
    };
};
