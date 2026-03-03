const std = @import("std");

pub const summaryStateType = enum {
    available,
    not_available,
    not_supported,
    failed,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .not_available = "NOT_AVAILABLE",
        .not_supported = "NOT_SUPPORTED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .not_available => "NOT_AVAILABLE",
            .not_supported => "NOT_SUPPORTED",
            .failed => "FAILED",
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
