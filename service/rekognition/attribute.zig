const std = @import("std");

pub const Attribute = enum {
    default,
    all,
    age_range,
    beard,
    emotions,
    eye_direction,
    eyeglasses,
    eyes_open,
    gender,
    mouth_open,
    mustache,
    face_occluded,
    smile,
    sunglasses,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .all = "ALL",
        .age_range = "AGE_RANGE",
        .beard = "BEARD",
        .emotions = "EMOTIONS",
        .eye_direction = "EYE_DIRECTION",
        .eyeglasses = "EYEGLASSES",
        .eyes_open = "EYES_OPEN",
        .gender = "GENDER",
        .mouth_open = "MOUTH_OPEN",
        .mustache = "MUSTACHE",
        .face_occluded = "FACE_OCCLUDED",
        .smile = "SMILE",
        .sunglasses = "SUNGLASSES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .all => "ALL",
            .age_range => "AGE_RANGE",
            .beard => "BEARD",
            .emotions => "EMOTIONS",
            .eye_direction => "EYE_DIRECTION",
            .eyeglasses => "EYEGLASSES",
            .eyes_open => "EYES_OPEN",
            .gender => "GENDER",
            .mouth_open => "MOUTH_OPEN",
            .mustache => "MUSTACHE",
            .face_occluded => "FACE_OCCLUDED",
            .smile => "SMILE",
            .sunglasses => "SUNGLASSES",
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
