pub const UnsuccessfulFaceDeletionReason = enum {
    associated_to_an_existing_user,
    face_not_found,

    pub const json_field_names = .{
        .associated_to_an_existing_user = "ASSOCIATED_TO_AN_EXISTING_USER",
        .face_not_found = "FACE_NOT_FOUND",
    };
};
