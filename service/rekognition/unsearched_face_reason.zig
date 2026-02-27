pub const UnsearchedFaceReason = enum {
    face_not_largest,
    exceeds_max_faces,
    extreme_pose,
    low_brightness,
    low_sharpness,
    low_confidence,
    small_bounding_box,
    low_face_quality,

    pub const json_field_names = .{
        .face_not_largest = "FACE_NOT_LARGEST",
        .exceeds_max_faces = "EXCEEDS_MAX_FACES",
        .extreme_pose = "EXTREME_POSE",
        .low_brightness = "LOW_BRIGHTNESS",
        .low_sharpness = "LOW_SHARPNESS",
        .low_confidence = "LOW_CONFIDENCE",
        .small_bounding_box = "SMALL_BOUNDING_BOX",
        .low_face_quality = "LOW_FACE_QUALITY",
    };
};
