const std = @import("std");

pub const CheckStatus = enum {
    okay,
    warning,
    @"error",
    not_available,
    fetch_failed,

    pub const json_field_names = .{
        .okay = "OKAY",
        .warning = "WARNING",
        .@"error" = "ERROR",
        .not_available = "NOT_AVAILABLE",
        .fetch_failed = "FETCH_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .okay => "OKAY",
            .warning => "WARNING",
            .@"error" => "ERROR",
            .not_available => "NOT_AVAILABLE",
            .fetch_failed => "FETCH_FAILED",
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
