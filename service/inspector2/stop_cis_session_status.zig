const std = @import("std");

pub const StopCisSessionStatus = enum {
    success,
    failed,
    interrupted,
    unsupported_os,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
        .unsupported_os = "UNSUPPORTED_OS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .failed => "FAILED",
            .interrupted => "INTERRUPTED",
            .unsupported_os => "UNSUPPORTED_OS",
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
