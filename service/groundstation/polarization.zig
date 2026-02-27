pub const Polarization = enum {
    right_hand,
    left_hand,
    none,

    pub const json_field_names = .{
        .right_hand = "RIGHT_HAND",
        .left_hand = "LEFT_HAND",
        .none = "NONE",
    };
};
