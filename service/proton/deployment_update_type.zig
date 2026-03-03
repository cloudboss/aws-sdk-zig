const std = @import("std");

pub const DeploymentUpdateType = enum {
    none,
    current_version,
    minor_version,
    major_version,

    pub const json_field_names = .{
        .none = "NONE",
        .current_version = "CURRENT_VERSION",
        .minor_version = "MINOR_VERSION",
        .major_version = "MAJOR_VERSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .current_version => "CURRENT_VERSION",
            .minor_version => "MINOR_VERSION",
            .major_version => "MAJOR_VERSION",
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
