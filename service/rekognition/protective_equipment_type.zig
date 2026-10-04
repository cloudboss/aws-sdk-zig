const std = @import("std");

pub const ProtectiveEquipmentType = enum {
    face_cover,
    hand_cover,
    head_cover,

    pub const json_field_names = .{
        .face_cover = "FACE_COVER",
        .hand_cover = "HAND_COVER",
        .head_cover = "HEAD_COVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_cover => "FACE_COVER",
            .hand_cover => "HAND_COVER",
            .head_cover => "HEAD_COVER",
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
