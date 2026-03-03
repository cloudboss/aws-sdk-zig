const std = @import("std");

pub const CustomEngineVersionStatus = enum {
    available,
    inactive,
    inactive_except_restore,

    pub const json_field_names = .{
        .available = "available",
        .inactive = "inactive",
        .inactive_except_restore = "inactive-except-restore",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "available",
            .inactive => "inactive",
            .inactive_except_restore => "inactive-except-restore",
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
