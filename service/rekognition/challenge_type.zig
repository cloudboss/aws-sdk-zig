const std = @import("std");

pub const ChallengeType = enum {
    face_movement_and_light_challenge,
    face_movement_challenge,

    pub const json_field_names = .{
        .face_movement_and_light_challenge = "FaceMovementAndLightChallenge",
        .face_movement_challenge = "FaceMovementChallenge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_movement_and_light_challenge => "FaceMovementAndLightChallenge",
            .face_movement_challenge => "FaceMovementChallenge",
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
