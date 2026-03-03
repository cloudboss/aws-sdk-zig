const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_not_largest => "FACE_NOT_LARGEST",
            .exceeds_max_faces => "EXCEEDS_MAX_FACES",
            .extreme_pose => "EXTREME_POSE",
            .low_brightness => "LOW_BRIGHTNESS",
            .low_sharpness => "LOW_SHARPNESS",
            .low_confidence => "LOW_CONFIDENCE",
            .small_bounding_box => "SMALL_BOUNDING_BOX",
            .low_face_quality => "LOW_FACE_QUALITY",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
