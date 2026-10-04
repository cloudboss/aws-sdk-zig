const std = @import("std");

/// The log level the user wants for their channel.
pub const LogLevel = enum {
    @"error",
    warning,
    info,
    debug,
    disabled,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .warning = "WARNING",
        .info = "INFO",
        .debug = "DEBUG",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "ERROR",
            .warning => "WARNING",
            .info => "INFO",
            .debug => "DEBUG",
            .disabled => "DISABLED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
