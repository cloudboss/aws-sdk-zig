const std = @import("std");

/// The log level for a log message. The log levels can be disabled, or set to
/// `ERROR` to display less verbose logs containing only error information,
/// or to `INFO` for more detailed logs.
pub const LogLevel = enum {
    info,
    @"error",
    disabled,

    pub const json_field_names = .{
        .info = "INFO",
        .@"error" = "ERROR",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .info => "INFO",
            .@"error" => "ERROR",
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
