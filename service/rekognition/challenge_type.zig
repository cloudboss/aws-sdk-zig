pub const ChallengeType = enum {
    face_movement_and_light_challenge,
    face_movement_challenge,

    pub const json_field_names = .{
        .face_movement_and_light_challenge = "FACE_MOVEMENT_AND_LIGHT_CHALLENGE",
        .face_movement_challenge = "FACE_MOVEMENT_CHALLENGE",
    };
};
