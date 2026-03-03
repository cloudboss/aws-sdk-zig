const BoundingBox = @import("bounding_box.zig").BoundingBox;
const FaceDetail = @import("face_detail.zig").FaceDetail;

/// Details about a person detected in a video analysis request.
pub const PersonDetail = struct {
    /// Bounding box around the detected person.
    bounding_box: ?BoundingBox = null,

    /// Face details for the detected person.
    face: ?FaceDetail = null,

    /// Identifier for the person detected person within a video. Use to keep track
    /// of the person throughout the video. The identifier is not stored by Amazon
    /// Rekognition.
    index: i64 = 0,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .face = "Face",
        .index = "Index",
    };
};
