const FaceDetail = @import("face_detail.zig").FaceDetail;

/// Information about a face detected in a video analysis request and the time
/// the face was detected in the video.
pub const FaceDetection = struct {
    /// The face properties for the detected face.
    face: ?FaceDetail,

    /// Time, in milliseconds from the start of the video, that the face was
    /// detected.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the face first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .face = "Face",
        .timestamp = "Timestamp",
    };
};
