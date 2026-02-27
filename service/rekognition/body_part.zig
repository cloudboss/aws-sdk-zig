pub const BodyPart = enum {
    face,
    head,
    left_hand,
    right_hand,

    pub const json_field_names = .{
        .face = "FACE",
        .head = "HEAD",
        .left_hand = "LEFT_HAND",
        .right_hand = "RIGHT_HAND",
    };
};
