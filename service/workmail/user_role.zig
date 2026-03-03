const std = @import("std");

pub const UserRole = enum {
    user,
    resource,
    system_user,
    remote_user,

    pub const json_field_names = .{
        .user = "USER",
        .resource = "RESOURCE",
        .system_user = "SYSTEM_USER",
        .remote_user = "REMOTE_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user => "USER",
            .resource => "RESOURCE",
            .system_user => "SYSTEM_USER",
            .remote_user => "REMOTE_USER",
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
