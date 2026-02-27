const UnsuccessfulFaceDeletionReason = @import("unsuccessful_face_deletion_reason.zig").UnsuccessfulFaceDeletionReason;

/// Contains metadata like FaceId, UserID, and Reasons, for a face that was
/// unsuccessfully
/// deleted.
pub const UnsuccessfulFaceDeletion = struct {
    /// A unique identifier assigned to the face.
    face_id: ?[]const u8,

    /// The reason why the deletion was unsuccessful.
    reasons: ?[]const UnsuccessfulFaceDeletionReason,

    /// A provided ID for the UserID. Unique within the collection.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .face_id = "FaceId",
        .reasons = "Reasons",
        .user_id = "UserId",
    };
};
