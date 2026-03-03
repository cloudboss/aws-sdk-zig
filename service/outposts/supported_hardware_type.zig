const std = @import("std");

pub const SupportedHardwareType = enum {
    rack,
    server,

    pub const json_field_names = .{
        .rack = "RACK",
        .server = "SERVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rack => "RACK",
            .server => "SERVER",
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
