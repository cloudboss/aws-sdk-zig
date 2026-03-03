const std = @import("std");

pub const PolicyTypeStatus = enum {
    enabled,
    pending_enable,
    pending_disable,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .pending_enable = "PENDING_ENABLE",
        .pending_disable = "PENDING_DISABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .pending_enable => "PENDING_ENABLE",
            .pending_disable => "PENDING_DISABLE",
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
