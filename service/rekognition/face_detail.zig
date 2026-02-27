const AgeRange = @import("age_range.zig").AgeRange;
const Beard = @import("beard.zig").Beard;
const BoundingBox = @import("bounding_box.zig").BoundingBox;
const Emotion = @import("emotion.zig").Emotion;
const EyeDirection = @import("eye_direction.zig").EyeDirection;
const Eyeglasses = @import("eyeglasses.zig").Eyeglasses;
const EyeOpen = @import("eye_open.zig").EyeOpen;
const FaceOccluded = @import("face_occluded.zig").FaceOccluded;
const Gender = @import("gender.zig").Gender;
const Landmark = @import("landmark.zig").Landmark;
const MouthOpen = @import("mouth_open.zig").MouthOpen;
const Mustache = @import("mustache.zig").Mustache;
const Pose = @import("pose.zig").Pose;
const ImageQuality = @import("image_quality.zig").ImageQuality;
const Smile = @import("smile.zig").Smile;
const Sunglasses = @import("sunglasses.zig").Sunglasses;

/// Structure containing attributes of the face that the algorithm detected.
///
/// A `FaceDetail` object contains either the default facial attributes or all
/// facial attributes. The default attributes are `BoundingBox`,
/// `Confidence`, `Landmarks`, `Pose`, and
/// `Quality`.
///
/// GetFaceDetection is the only Amazon Rekognition Video stored video operation
/// that can
/// return a `FaceDetail` object with all attributes. To specify which
/// attributes to
/// return, use the `FaceAttributes` input parameter for StartFaceDetection. The
/// following Amazon Rekognition Video operations return only the default
/// attributes. The corresponding Start operations don't have a `FaceAttributes`
/// input
/// parameter:
///
/// * GetCelebrityRecognition
///
/// * GetPersonTracking
///
/// * GetFaceSearch
///
/// The Amazon Rekognition Image DetectFaces and IndexFaces operations
/// can return all facial attributes. To specify which attributes to return, use
/// the
/// `Attributes` input parameter for `DetectFaces`. For
/// `IndexFaces`, use the `DetectAttributes` input parameter.
pub const FaceDetail = struct {
    /// The estimated age range, in years, for the face. Low represents the lowest
    /// estimated
    /// age and High represents the highest estimated age.
    age_range: ?AgeRange,

    /// Indicates whether or not the face has a beard, and the confidence level in
    /// the
    /// determination.
    beard: ?Beard,

    /// Bounding box of the face. Default attribute.
    bounding_box: ?BoundingBox,

    /// Confidence level that the bounding box contains a face (and not a different
    /// object such
    /// as a tree). Default attribute.
    confidence: ?f32,

    /// The emotions that appear to be expressed on the face, and the confidence
    /// level in the
    /// determination. The API is only making a determination of the physical
    /// appearance of a person's
    /// face. It is not a determination of the person’s internal emotional state and
    /// should not be
    /// used in such a way. For example, a person pretending to have a sad face
    /// might not be sad
    /// emotionally.
    emotions: ?[]const Emotion,

    /// Indicates the direction the eyes are gazing in, as defined by pitch and yaw.
    eye_direction: ?EyeDirection,

    /// Indicates whether or not the face is wearing eye glasses, and the confidence
    /// level in
    /// the determination.
    eyeglasses: ?Eyeglasses,

    /// Indicates whether or not the eyes on the face are open, and the confidence
    /// level in the
    /// determination.
    eyes_open: ?EyeOpen,

    /// `FaceOccluded` should return "true" with a high confidence score if a
    /// detected
    /// face’s eyes, nose, and mouth are partially captured or if they are covered
    /// by masks, dark
    /// sunglasses, cell phones, hands, or other objects. `FaceOccluded` should
    /// return
    /// "false" with a high confidence score if common occurrences that do not
    /// impact face
    /// verification are detected, such as eye glasses, lightly tinted sunglasses,
    /// strands of hair,
    /// and others.
    face_occluded: ?FaceOccluded,

    /// The predicted gender of a detected face.
    gender: ?Gender,

    /// Indicates the location of landmarks on the face. Default attribute.
    landmarks: ?[]const Landmark,

    /// Indicates whether or not the mouth on the face is open, and the confidence
    /// level in the
    /// determination.
    mouth_open: ?MouthOpen,

    /// Indicates whether or not the face has a mustache, and the confidence level
    /// in the
    /// determination.
    mustache: ?Mustache,

    /// Indicates the pose of the face as determined by its pitch, roll, and yaw.
    /// Default
    /// attribute.
    pose: ?Pose,

    /// Identifies image brightness and sharpness. Default attribute.
    quality: ?ImageQuality,

    /// Indicates whether or not the face is smiling, and the confidence level in
    /// the
    /// determination.
    smile: ?Smile,

    /// Indicates whether or not the face is wearing sunglasses, and the confidence
    /// level in
    /// the determination.
    sunglasses: ?Sunglasses,

    pub const json_field_names = .{
        .age_range = "AgeRange",
        .beard = "Beard",
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .emotions = "Emotions",
        .eye_direction = "EyeDirection",
        .eyeglasses = "Eyeglasses",
        .eyes_open = "EyesOpen",
        .face_occluded = "FaceOccluded",
        .gender = "Gender",
        .landmarks = "Landmarks",
        .mouth_open = "MouthOpen",
        .mustache = "Mustache",
        .pose = "Pose",
        .quality = "Quality",
        .smile = "Smile",
        .sunglasses = "Sunglasses",
    };
};
