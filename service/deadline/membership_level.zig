const std = @import("std");

pub const MembershipLevel = enum {
    viewer,
    contributor,
    owner,
    manager,

    pub const json_field_names = .{
        .viewer = "VIEWER",
        .contributor = "CONTRIBUTOR",
        .owner = "OWNER",
        .manager = "MANAGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .viewer => "VIEWER",
            .contributor => "CONTRIBUTOR",
            .owner => "OWNER",
            .manager => "MANAGER",
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
