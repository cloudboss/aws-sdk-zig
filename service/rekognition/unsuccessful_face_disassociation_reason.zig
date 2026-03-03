const std = @import("std");

pub const UnsuccessfulFaceDisassociationReason = enum {
    face_not_found,
    associated_to_a_different_user,

    pub const json_field_names = .{
        .face_not_found = "FACE_NOT_FOUND",
        .associated_to_a_different_user = "ASSOCIATED_TO_A_DIFFERENT_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .face_not_found => "FACE_NOT_FOUND",
            .associated_to_a_different_user => "ASSOCIATED_TO_A_DIFFERENT_USER",
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
