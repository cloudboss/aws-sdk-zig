pub const UnsuccessfulFaceDisassociationReason = enum {
    face_not_found,
    associated_to_a_different_user,

    pub const json_field_names = .{
        .face_not_found = "FACE_NOT_FOUND",
        .associated_to_a_different_user = "ASSOCIATED_TO_A_DIFFERENT_USER",
    };
};
