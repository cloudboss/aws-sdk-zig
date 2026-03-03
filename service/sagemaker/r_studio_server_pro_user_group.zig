const std = @import("std");

pub const RStudioServerProUserGroup = enum {
    admin,
    user,

    pub const json_field_names = .{
        .admin = "R_STUDIO_ADMIN",
        .user = "R_STUDIO_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .admin => "R_STUDIO_ADMIN",
            .user => "R_STUDIO_USER",
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
