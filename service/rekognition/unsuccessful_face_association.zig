const UnsuccessfulFaceAssociationReason = @import("unsuccessful_face_association_reason.zig").UnsuccessfulFaceAssociationReason;

/// Contains metadata like FaceId, UserID, and Reasons, for a face that was
/// unsuccessfully
/// associated.
pub const UnsuccessfulFaceAssociation = struct {
    /// Match confidence with the UserID, provides information regarding if a face
    /// association was
    /// unsuccessful because it didn't meet UserMatchThreshold.
    confidence: ?f32 = null,

    /// A unique identifier assigned to the face.
    face_id: ?[]const u8 = null,

    /// The reason why the association was unsuccessful.
    reasons: ?[]const UnsuccessfulFaceAssociationReason = null,

    /// A provided ID for the UserID. Unique within the collection.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .face_id = "FaceId",
        .reasons = "Reasons",
        .user_id = "UserId",
    };
};
