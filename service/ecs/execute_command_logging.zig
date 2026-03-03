const std = @import("std");

pub const ExecuteCommandLogging = enum {
    none,
    default,
    override,

    pub const json_field_names = .{
        .none = "NONE",
        .default = "DEFAULT",
        .override = "OVERRIDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .default => "DEFAULT",
            .override => "OVERRIDE",
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
