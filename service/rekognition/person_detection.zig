const PersonDetail = @import("person_detail.zig").PersonDetail;

/// Details and path tracking information for a single time a person's path is
/// tracked in a video.
/// Amazon Rekognition operations that track people's paths return an array of
/// `PersonDetection` objects
/// with elements for each time a person's path is tracked in a video.
///
/// For more information, see GetPersonTracking in the Amazon Rekognition
/// Developer Guide.
pub const PersonDetection = struct {
    /// Details about a person whose path was tracked in a video.
    person: ?PersonDetail,

    /// The time, in milliseconds from the start of the video, that the person's
    /// path was tracked.
    /// Note that `Timestamp` is not guaranteed to be accurate to the individual
    /// frame where the person's path first appears.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .person = "Person",
        .timestamp = "Timestamp",
    };
};
