/// Provides face metadata for the faces that are associated to a specific
/// UserID.
pub const AssociatedFace = struct {
    /// Unique identifier assigned to the face.
    face_id: ?[]const u8,

    pub const json_field_names = .{
        .face_id = "FaceId",
    };
};
