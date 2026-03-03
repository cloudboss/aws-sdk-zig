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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
