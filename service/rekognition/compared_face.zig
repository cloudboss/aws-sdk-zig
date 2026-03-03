const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Emotion = @import("emotion.zig").Emotion;
const Landmark = @import("landmark.zig").Landmark;
const Pose = @import("pose.zig").Pose;
const ImageQuality = @import("image_quality.zig").ImageQuality;
const Smile = @import("smile.zig").Smile;

/// Provides face metadata for target image faces that are analyzed by
/// `CompareFaces` and `RecognizeCelebrities`.
pub const ComparedFace = struct {
    /// Bounding box of the face.
    bounding_box: ?BoundingBox = null,

    /// Level of confidence that what the bounding box contains is a face.
    confidence: ?f32 = null,

    /// The emotions that appear to be expressed on the face, and the confidence
    /// level in the
    /// determination. Valid values include "Happy", "Sad", "Angry", "Confused",
    /// "Disgusted",
    /// "Surprised", "Calm", "Unknown", and "Fear".
    emotions: ?[]const Emotion = null,

    /// An array of facial landmarks.
    landmarks: ?[]const Landmark = null,

    /// Indicates the pose of the face as determined by its pitch, roll, and yaw.
    pose: ?Pose = null,

    /// Identifies face image brightness and sharpness.
    quality: ?ImageQuality = null,

    /// Indicates whether or not the face is smiling, and the confidence level in
    /// the
    /// determination.
    smile: ?Smile = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .emotions = "Emotions",
        .landmarks = "Landmarks",
        .pose = "Pose",
        .quality = "Quality",
        .smile = "Smile",
    };
};
