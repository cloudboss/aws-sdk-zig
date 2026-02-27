const Face = @import("face.zig").Face;
const FaceDetail = @import("face_detail.zig").FaceDetail;

/// Object containing both the face metadata (stored in the backend database),
/// and facial
/// attributes that are detected but aren't stored in the database.
pub const FaceRecord = struct {
    /// Describes the face properties such as the bounding box, face ID, image ID of
    /// the input
    /// image, and external image ID that you assigned.
    face: ?Face,

    /// Structure containing attributes of the face that the algorithm detected.
    face_detail: ?FaceDetail,

    pub const json_field_names = .{
        .face = "Face",
        .face_detail = "FaceDetail",
    };
};
