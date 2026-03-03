const std = @import("std");

pub const InstanceAccessControlAttributeConfigurationStatus = enum {
    enabled,
    creation_in_progress,
    creation_failed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_failed = "CREATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .creation_in_progress => "CREATION_IN_PROGRESS",
            .creation_failed => "CREATION_FAILED",
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
