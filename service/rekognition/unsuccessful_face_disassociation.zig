const UnsuccessfulFaceDisassociationReason = @import("unsuccessful_face_disassociation_reason.zig").UnsuccessfulFaceDisassociationReason;

/// Contains metadata like FaceId, UserID, and Reasons, for a face that was
/// unsuccessfully
/// disassociated.
pub const UnsuccessfulFaceDisassociation = struct {
    /// A unique identifier assigned to the face.
    face_id: ?[]const u8,

    /// The reason why the deletion was unsuccessful.
    reasons: ?[]const UnsuccessfulFaceDisassociationReason,

    /// A provided ID for the UserID. Unique within the collection.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .face_id = "FaceId",
        .reasons = "Reasons",
        .user_id = "UserId",
    };
};
