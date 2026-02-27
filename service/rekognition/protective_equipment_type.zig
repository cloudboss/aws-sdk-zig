pub const ProtectiveEquipmentType = enum {
    face_cover,
    hand_cover,
    head_cover,

    pub const json_field_names = .{
        .face_cover = "FACE_COVER",
        .hand_cover = "HAND_COVER",
        .head_cover = "HEAD_COVER",
    };
};
