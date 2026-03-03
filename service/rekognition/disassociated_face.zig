/// Provides face metadata for the faces that are disassociated from a specific
/// UserID.
pub const DisassociatedFace = struct {
    /// Unique identifier assigned to the face.
    face_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .face_id = "FaceId",
    };
};
