pub const UnsuccessfulFaceAssociationReason = enum {
    face_not_found,
    associated_to_a_different_user,
    low_match_confidence,

    pub const json_field_names = .{
        .face_not_found = "FACE_NOT_FOUND",
        .associated_to_a_different_user = "ASSOCIATED_TO_A_DIFFERENT_USER",
        .low_match_confidence = "LOW_MATCH_CONFIDENCE",
    };
};
