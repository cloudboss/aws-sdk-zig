const std = @import("std");

pub const FeedbackCode = enum {
    face_not_visible,
    face_obstruction_detected,
    low_video_quality_detected,
    face_not_aligned,
    eyes_closed_detected,
    low_lighting_detected,
    high_lighting_detected,

    pub const json_field_names = .{
        .face_not_visible = "FACE_NOT_VISIBLE",
        .face_obstruction_detected = "FACE_OBSTRUCTION_DETECTED",
        .low_video_quality_detected = "LOW_VIDEO_QUALITY_DETECTED",
        .face_not_aligned = "FACE_NOT_ALIGNED",
        .eyes_closed_detected = "EYES_CLOSED_DETECTED",
        .low_lighting_detected = "LOW_LIGHTING_DETECTED",
        .high_lighting_detected = "HIGH_LIGHTING_DETECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_not_visible => "FACE_NOT_VISIBLE",
            .face_obstruction_detected => "FACE_OBSTRUCTION_DETECTED",
            .low_video_quality_detected => "LOW_VIDEO_QUALITY_DETECTED",
            .face_not_aligned => "FACE_NOT_ALIGNED",
            .eyes_closed_detected => "EYES_CLOSED_DETECTED",
            .low_lighting_detected => "LOW_LIGHTING_DETECTED",
            .high_lighting_detected => "HIGH_LIGHTING_DETECTED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
