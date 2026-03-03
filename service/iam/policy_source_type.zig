const std = @import("std");

pub const PolicySourceType = enum {
    user,
    group,
    role,
    aws_managed,
    user_managed,
    resource,
    none,

    pub const json_field_names = .{
        .user = "user",
        .group = "group",
        .role = "role",
        .aws_managed = "aws-managed",
        .user_managed = "user-managed",
        .resource = "resource",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "user",
            .group => "group",
            .role => "role",
            .aws_managed => "aws-managed",
            .user_managed => "user-managed",
            .resource => "resource",
            .none => "none",
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
