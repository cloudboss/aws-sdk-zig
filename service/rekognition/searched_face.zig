/// Provides face metadata such as FaceId, BoundingBox, Confidence of the input
/// face used for
/// search.
pub const SearchedFace = struct {
    /// Unique identifier assigned to the face.
    face_id: ?[]const u8,

    pub const json_field_names = .{
        .face_id = "FaceId",
    };
};
