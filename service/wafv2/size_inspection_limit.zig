const std = @import("std");

pub const SizeInspectionLimit = enum {
    kb_16,
    kb_32,
    kb_48,
    kb_64,

    pub const json_field_names = .{
        .kb_16 = "KB_16",
        .kb_32 = "KB_32",
        .kb_48 = "KB_48",
        .kb_64 = "KB_64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kb_16 => "KB_16",
            .kb_32 => "KB_32",
            .kb_48 => "KB_48",
            .kb_64 => "KB_64",
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
