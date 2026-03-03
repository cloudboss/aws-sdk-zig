const std = @import("std");

pub const SubjectKeyIdCOption = enum {
    user_name,
    user_id,
    email,

    pub const json_field_names = .{
        .user_name = "UserName",
        .user_id = "UserId",
        .email = "Email",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_name => "UserName",
            .user_id => "UserId",
            .email => "Email",
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
