const std = @import("std");

pub const UnsuccessfulFaceDeletionReason = enum {
    associated_to_an_existing_user,
    face_not_found,

    pub const json_field_names = .{
        .associated_to_an_existing_user = "ASSOCIATED_TO_AN_EXISTING_USER",
        .face_not_found = "FACE_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .associated_to_an_existing_user => "ASSOCIATED_TO_AN_EXISTING_USER",
            .face_not_found => "FACE_NOT_FOUND",
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
