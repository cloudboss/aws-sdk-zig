const std = @import("std");

pub const UnsuccessfulFaceAssociationReason = enum {
    face_not_found,
    associated_to_a_different_user,
    low_match_confidence,

    pub const json_field_names = .{
        .face_not_found = "FACE_NOT_FOUND",
        .associated_to_a_different_user = "ASSOCIATED_TO_A_DIFFERENT_USER",
        .low_match_confidence = "LOW_MATCH_CONFIDENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_not_found => "FACE_NOT_FOUND",
            .associated_to_a_different_user => "ASSOCIATED_TO_A_DIFFERENT_USER",
            .low_match_confidence => "LOW_MATCH_CONFIDENCE",
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
