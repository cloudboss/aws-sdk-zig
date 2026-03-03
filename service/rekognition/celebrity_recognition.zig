const CelebrityDetail = @import("celebrity_detail.zig").CelebrityDetail;

/// Information about a detected celebrity and the time the celebrity was
/// detected in a stored video.
/// For more information, see GetCelebrityRecognition in the Amazon Rekognition
/// Developer Guide.
pub const CelebrityRecognition = struct {
    /// Information about a recognized celebrity.
    celebrity: ?CelebrityDetail = null,

    /// The time, in milliseconds from the start of the video, that the celebrity
    /// was recognized.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the celebrity first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .celebrity = "Celebrity",
        .timestamp = "Timestamp",
    };
};
